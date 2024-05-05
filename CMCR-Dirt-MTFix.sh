#!/bin/bash

#Copia de XML previa
xml_folder="Files"
destination_folder="$HOME/.local/share/Steam/steamapps/common/DiRT/system/"

cp -f "$xml_folder"/*.xml "$destination_folder"

# Obtener el número de cores lógicos del CPU
cores=$(nproc --all)

# Testeo del Script
#cores=64

# Definir los valores válidos de cores
valid_cores=(8 12)
echo "This mod allows Colin MCRae DiRT to use 2,4,6,8 or 12 cores."

# Definir el valor de grid_cores basado en el número de cores
if [ $cores -gt 12 ]; then
    dirt_cores=12
    echo "Your CPU has $cores, it exceeds the max core count for the game. Some cores won't be used."
elif [ $cores -lt 8 ]; then
    dirt_cores=8
    echo "Colin McRae DiRT already supports your CPU core count."
else
    # Verificar si el número de cores está en la lista de valid_cores
    if [[ " ${valid_cores[@]} " =~ " $cores " ]]; then
        dirt_cores=$cores
    else
        # Obtener el valor de valid_cores inmediatamente inferior a $cores
        for i in "${valid_cores[@]}"; do
            if [ $i -lt $cores ]; then
                dirt_cores=$i
            fi
        done
    fi
fi

# Ruta del archivo de plantilla y archivo de salida
template_file="Template.xml"
output_file="$HOME/.local/share/Steam/steamapps/common/DiRT/system/hardware_settings_restrictions.xml"

# Reemplazar el valor "_Y_" por el valor de grid_cores en la plantilla
sed "s/_Y_/$dirt_cores/g" "$template_file" > "$output_file"

if [ $cores -ge 8 ]; then
    echo "Game has been patched. Colin McRae DiRT will use $dirt_cores cores."
fi
