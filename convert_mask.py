from PIL import Image
import numpy as np
import scipy
import os
from glob import glob
import matplotlib.pyplot as plt
def fun1():
    probs_map_dir="PROBS_MAP_PATH"
    image_dir="PROBS_MAP_IMG_PATH"
    # assert len(os.listdir(image_dir))==0
    probs_map_fps=glob(os.path.join(probs_map_dir,"*.npy"))
    for fp in probs_map_fps:
        arr=np.load(fp)
        fn_noext=os.path.splitext(os.path.basename(fp))[0]
        print(fn_noext)
        plt.imshow(arr.transpose(), vmin=0, vmax=1, cmap='jet')
        img=Image.fromarray(arr)
        plt.savefig(os.path.join(image_dir,fn_noext+".png"))
def fun2():
    original_mask_dir="/data/liz0f/CAMELYON16/testing/evaluation/evaluation_masks"
    converted_mask_dir="/data/liz0f/CAMELYON16/testing/evaluation/evaluation_masks_converted"
    for fn in os.listdir(original_mask_dir):
        if fn.endswith("png"):
            print(fn)
            img=Image.open(os.path.join(original_mask_dir,fn))
            img_arr=np.array(img)
            img_arr[img_arr>0]=255
            img=Image.fromarray(img_arr)
            img.save(os.path.join(converted_mask_dir,fn))
if __name__=="__main__":
    fun2()