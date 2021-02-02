test_slides_dir="/data/liz0f/CAMELYON16/testing/images"
# python wsi/bin/patch_gen.py ./WSI_TRAIN/ coords/tumor_train.txt PATCHES_TUMOR_TRAIN/
# python wsi/bin/patch_gen.py WSI_TRAIN/ coords/normal_train.txt PATCHES_NORMAL_TRAIN/
# python wsi/bin/patch_gen.py WSI_TRAIN/ coords/tumor_valid.txt PATCHES_TUMOR_VALID/
# python wsi/bin/patch_gen.py WSI_TRAIN/ coords/normal_valid.txt PATCHES_NORMAL_VALID/
# python wsi/bin/train.py configs/resnet18_crf.json resnet18_crf_save_dir
for fp in  "${test_slides_dir}"/*.tif
do 
    fn="$(basename "$fp")"
    case="${fn%.tif}"
    if ! [ -f ./COORD_PATH/${case}.csv ]; then
        echo "$case"
        python wsi/bin/tissue_mask.py /data/liz0f/CAMELYON16/testing/images/${case}.tif ./MASK_PATH/${case}.npy
        python wsi/bin/probs_map.py /data/liz0f/CAMELYON16/testing/images/${case}.tif ./ckpt/resnet18_crf.ckpt ./configs/resnet18_crf.json ./MASK_PATH/${case}.npy ./PROBS_MAP_PATH/${case}.npy
        python wsi/bin/nms.py ./PROBS_MAP_PATH/${case}.npy ./COORD_PATH/${case}.csv
    fi
done