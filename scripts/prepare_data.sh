#! /bin/sh

mkdir -p data
cd data

if [ "$1" = "3DChairs" ]; then
    if [ -f "rendered_chairs.tar" ]; then
        tar -xvf rendered_chairs.tar
        root=rendered_chairs
        new_root="3DChairs/images"
        rm $root"/all_chair_names.mat"
        mkdir -p $new_root
        n=1
        for dir in `ls -1t $root`; do
            for imgpath in `ls -1t $root/$dir/renders/*`; do
                imgname=$(echo "$imgpath" | cut -d"/" -f4)
                newpath=$img" "$new_root"/"$n"_"$imgname
                mv $imgpath $newpath
                n=$((n+1))
            done
        done
        rm -rf $root

    else
        echo "download 3DChairs dataset."
        wget https://www.di.ens.fr/willow/research/seeing3Dchairs/data/rendered_chairs.tar
    fi

elif [ "$1" = "dsprites" ]; then
    git clone https://github.com/deepmind/dsprites-dataset.git
    cd dsprites-dataset
    rm -rf .git* *.md LICENSE *.ipynb *.gif *.hdf5

elif [ "$1" = "CelebA" ]; then
    datapath="/data/hc/SCAN/dataset/" # this should be defined as the directory containing ima_align_celeba.zip
    if [ ! -d $datapath"img_align_celeba" ]; then
        unzip $datapath"img_align_celeba.zip" -d $datapath
    fi
    if [ ! -d $datapath"CelebA" ]; then
        mkdir $datapath"CelebA"
    fi
    mv $datapath"img_align_celeba" $datapath"CelebA"
fi