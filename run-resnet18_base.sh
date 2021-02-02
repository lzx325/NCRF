test_slides_dir="/data/liz0f/CAMELYON16/testing/images"
for fp in  "${test_slides_dir}"/*.tif
do 
    fn="$(basename "$fp")"
    case="${fn%.tif}"
    if ! [ -f ./COORD_PATH-resnet18_base/${case}.csv ]; then
        echo "$case"
        python wsi/bin/probs_map.py \
        /data/liz0f/CAMELYON16/testing/images/${case}.tif \
        ./ckpt/resnet18_base.ckpt ./configs/resnet18_base.json \
        ./MASK_PATH/${case}.npy \
        ./PROBS_MAP_PATH-resnet18_base/${case}.npy

        python wsi/bin/nms.py \
        ./PROBS_MAP_PATH-resnet18_base/${case}.npy \
        ./COORD_PATH-resnet18_base/${case}.csv
    fi
done