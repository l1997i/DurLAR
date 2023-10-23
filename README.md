![DurLAR](https://github.com/l1997i/DurLAR/blob/main/head.png?raw=true)

## Sensor placement

- **LiDAR**: [Ouster OS1-128 LiDAR sensor](https://ouster.com/products/os1-lidar-sensor/) with 128 channels vertical resolution

- **Stereo** Camera: [Carnegie Robotics MultiSense S21 stereo camera](https://carnegierobotics.com/products/multisense-s21/) with grayscale, colour, and IR enhanced imagers, 2048x1088 @ 2MP resolution

- **GNSS/INS**: [OxTS RT3000v3](https://www.oxts.com/products/rt3000-v3/) global navigation satellite and inertial navigation system, supporting localization from GPS, GLONASS, BeiDou, Galileo, PPP and SBAS constellations

- **Lux Meter**: [Yocto Light V3](http://www.yoctopuce.com/EN/products/usb-environmental-sensors/yocto-light-v3), a USB ambient light sensor (lux meter), measuring ambient light up to 100,000 lux


## Panoramic Imagery

<br>
<p align="center">
    <img src="https://github.com/l1997i/DurLAR/blob/main/reflect_center.gif?raw=true" width="100%"/>
    <h5 id="title" align="center">Reflectivity imagery</h5>
</br>

<br>
<p align="center">
    <img src="https://github.com/l1997i/DurLAR/blob/main/ambient_center.gif?raw=true" width="100%"/>
    <h5 id="title" align="center">Ambient imagery</h5>
</br>




## File Description

Each file contains 8 topics for each frame in DurLAR dataset,

- `ambient/`: panoramic ambient imagery
- `reflec/`: panoramic reflectivity imagery
- `image_01/`: right camera (grayscale+synced+rectified)
- `image_02/`: left RGB camera (synced+rectified)
- `ouster_points`: ouster LiDAR point cloud (KITTI-compatible binary format)
- `gps`, `imu`, `lux`: csv file format

The structure of the provided DurLAR full dataset zip file,  

```
DurLAR_<date>/  
├── ambient/  
│   ├── data/  
│   │   └── <frame_number.png>   [ ..... ]   
│   └── timestamp.txt  
├── gps/  
│   └── data.csv  
├── image_01/  
│   ├── data/  
│   │   └── <frame_number.png>   [ ..... ]   
│   └── timestamp.txt  
├── image_02/  
│   ├── data/  
│   │   └── <frame_number.png>   [ ..... ]   
│   └── timestamp.txt  
├── imu/  
│   └── data.csv  
├── lux/  
│   └── data.csv  
├── ouster_points/  
│   ├── data/  
│   │   └── <frame_number.bin>   [ ..... ]   
│   └── timestamp.txt  
├── reflec/  
│   ├── data/  
│   │   └── <frame_number.png>   [ ..... ]   
│   └── timestamp.txt  
└── readme.md                    [ this README file ]  
```  

The structure of the provided calibration zip file,  

```
DurLAR_calibs/  
├── calib_cam_to_cam.txt              [ Camera to camera calibration results ]   
├── calib_imu_to_lidar.txt            [ IMU to LiDAR calibration results ]   
└── calib_lidar_to_cam.txt            [ LiDAR to camera calibration results ]   
```

## Download the Dataset

[Download the **calibration files**](https://github.com/l1997i/DurLAR/raw/main/DurLAR_calibs.zip)  
[Download the **exemplar dataset** (600 frames)](https://collections.durham.ac.uk/collections/r2gq67jr192)  

### Access for the full dataset

You can request access to the full dataset in **either** of the way you choose. 您可任选以下其中**任意**链接申请访问完整数据集。

[1. Access for the full dataset](https://forms.gle/ZjSs3PWeGjjnXmwg9)  
[2. 申请访问完整数据集](https://wj.qq.com/s2/9459309/4cdd/)

### Usage of the downloading script

Once you have completed either of the forms above, the download script and instruction will be showed on the end page **automatically**. You will be able to download the DurLAR dataset using the **command line** (run in the Ubuntu Terminal). For the first time, it’s very likely that you need to make the durlar_download file executable, using follow command,

``` bash
chmod +x durlar_download
```
 
By default, this script downloads the small subset for simple testing. Use the following command: 

```bash
./durlar_download
```
 
At the same time, you can also choose to download datasets of different sizes and test drives. 

```
usage: ./durlar_download [dataset_sample_size] [drive]
dataset_sample_size = [ small | medium | full ]
drive = 1 ... 5
```
 
The DurLAR dataset is very huge, so please download the full dataset only when necessary, and use the following command: 

```bash
./durlar_download full 5
```
 
Your network must not have any problems during the entire download process. In case of network problems, please delete all DurLAR dataset folder and re-run the download command.
 
The download script is now only support Ubuntu (tested on Ubuntu 18.04 and Ubuntu 20.04, amd64) for now. Please refer to https://collections.durham.ac.uk/collections/r2gq67jr192 to download the dataset for other OS manually.

# Folder \#Frame Verification

For the convenience of verifying folder data, we provide the number of frames each folder contains.

| Folder   | # of Frames |
|----------|-------------|
| 20210716 | 41993       |
| 20210901 | 23347       |
| 20211012 | 28642       |
| 20211208 | 26850       |
| 20211209 | 25079       |
|**total** | **145911**  |

---

## Reference

If you are making use of this work in any way (including our dataset and toolkits), you must please reference the following paper in any report, publication, presentation, software release or any other associated materials:

[DurLAR: A High-fidelity 128-channel LiDAR Dataset with Panoramic Ambient and Reflectivity Imagery for Multi-modal Autonomous Driving Applications](https://dro.dur.ac.uk/34293/)
(Li Li, Khalid N. Ismail, Hubert P. H. Shum and Toby P. Breckon), In Int. Conf. 3D Vision, 2021. [[pdf](https://www.l1997i.com/assets/pdf/li21durlar_arxiv_compressed.pdf)] [[video](https://youtu.be/1IAC9RbNYjY)][[poster](https://www.l1997i.com/assets/pdf/li21durlar_poster_v2_compressed.pdf)]

```
@inproceedings{li21durlar,
 author = {Li, L. and Ismail, K.N. and Shum, H.P.H. and Breckon, T.P.},
 title = {DurLAR: A High-fidelity 128-channel LiDAR Dataset with Panoramic Ambient and Reflectivity Imagery for Multi-modal Autonomous Driving Applications},
 booktitle = {Proc. Int. Conf. on 3D Vision},
 year = {2021},
 month = {December},
 publisher = {IEEE},
 keywords = {autonomous driving, dataset, high resolution LiDAR, flash LiDAR, ground truth depth, dense depth, monocular depth estimation, stereo vision, 3D},
 category = {automotive 3Dvision},
}
```
---
