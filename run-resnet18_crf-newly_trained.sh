test_slides_dir="/data/liz0f/CAMELYON16/testing/images"
for fp in  "${test_slides_dir}"/*.tif
do 
    fn="$(basename "$fp")"
    case="${fn%.tif}"
    if ! [ -f ./COORD_PATH-resnet18_crf-newly_trained/${case}.csv ]; then
        echo "$case"
        python wsi/bin/probs_map.py /data/liz0f/CAMELYON16/testing/images/${case}.tif ./resnet18_crf_save_dir/best.ckpt ./configs/resnet18_crf.json ./MASK_PATH/${case}.npy ./PROBS_MAP_PATH-resnet18_crf-newly_trained/${case}.npy
        python wsi/bin/nms.py ./PROBS_MAP_PATH-resnet18_crf-newly_trained/${case}.npy ./COORD_PATH-resnet18_crf-newly_trained/${case}.csv
    fi
done