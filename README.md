[![Durham](https://img.shields.io/badge/UK-Durham-blueviolet)](https://durham-repository.worktribe.com/output/1138941/durlar-a-high-fidelity-128-channel-lidar-dataset-with-panoramic-ambient-and-reflectivity-imagery-for-multi-modal-autonomous-driving-applications)
[![arXiv](https://img.shields.io/badge/arXiv-2406.10068-b31b1b.svg)](https://arxiv.org/abs/2406.10068)
[![GitHub license](https://img.shields.io/badge/license-Apache2.0-blue.svg)](https://github.com/l1997i/lim3d/blob/main/LICENSE)
![Stars](https://img.shields.io/github/stars/l1997i/durlar?style=social)

# DurLAR: A High-Fidelity 128-Channel LiDAR Dataset

<!-- ![DurLAR](https://github.com/l1997i/DurLAR/blob/main/head.png?raw=true) -->

https://github.com/l1997i/DurLAR/assets/35445094/2c6d4056-a6de-4fad-9576-693efe2860f0

## News

- [2025/03/16] We provide the [download link](https://huggingface.co/datasets/l1997i/DurLAR) for our DurLAR dataset hosted on Hugging Face, along with the corresponding [download script](durlar_hf_download_script.sh).
- [2024/12/05] We provide the **intrinsic parameters** of our OS1-128 LiDAR [[download]](os1-128.json).

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

## Get Started

- [A quick look: the **exemplar dataset** (600 frames)](https://huggingface.co/datasets/l1997i/DurLAR_S)
- [**The full dataset** hosted on Hugging Face](https://huggingface.co/datasets/l1997i/DurLAR)
- [Download the **calibration files**](https://github.com/l1997i/DurLAR/raw/main/DurLAR_calibs.zip)  
- [Download the **calibration files** (v2, targetless)](https://github.com/l1997i/DurLAR/raw/main/DurLAR_calibs_v2.zip) 
- [Download the **exemplar ROS bag** (for targetless calibration)](https://durhamuniversity-my.sharepoint.com/:f:/g/personal/mznv82_durham_ac_uk/Ei28Yy-Gb_BKoavvJ6R_jLcBfTZ_xM5cZhEFgMFNK9HhyQ?e=rxPgI9)
- [Download the **exemplar dataset** (600 frames)](https://collections.durham.ac.uk/collections/r2gq67jr192)
- [Download the **full dataset**](https://github.com/l1997i/DurLAR?tab=readme-ov-file#access-for-the-full-dataset) (Fill in the form to request access to the full dataset)

> Note that [we did not include CSV header information](https://github.com/l1997i/DurLAR/issues/9) in the [**exemplar dataset** (600 frames)](https://collections.durham.ac.uk/collections/r2gq67jr192). You can refer to [Header of csv files](https://github.com/l1997i/DurLAR?tab=readme-ov-file#header-of-csv-files) to get the first line of the `csv` files.

> **calibration files** (v2, targetless): Following the publication of the proposed DurLAR dataset and the corresponding paper, we identify a more advanced [targetless calibration method](https://github.com/koide3/direct_visual_lidar_calibration) ([#4](https://github.com/l1997i/DurLAR/issues/4)) that surpasses the LiDAR-camera calibration technique previously employed. We provide [**exemplar ROS bag**](https://durhamuniversity-my.sharepoint.com/:f:/g/personal/mznv82_durham_ac_uk/Ei28Yy-Gb_BKoavvJ6R_jLcBfTZ_xM5cZhEFgMFNK9HhyQ?e=rxPgI9) for [targetless calibration](https://github.com/koide3/direct_visual_lidar_calibration), and also corresponding [calibration results (v2)](https://github.com/l1997i/DurLAR/raw/main/DurLAR_calibs_v2.zip). Please refer to [Appendix (arXiv)](https://arxiv.org/pdf/2406.10068) for more details. 

###  Prerequisites

- Before starting, ensure you have the [**Hugging Face CLI (huggingface_hub)**](https://huggingface.co/docs/huggingface_hub/en/guides/cli) installed:

  ​	Install it via: ```pip install -U "huggingface_hub[cli]"```

- Since the **DurLAR dataset** is a [gated (restricted access) dataset](https://huggingface.co/docs/hub/datasets-gated) on Hugging Face, you need to authenticate before downloading it. 

  - You first need a Hugging Face account. If you don’t have one, please register.
  - Authenticate via the command line **on the computer where you want to download the dataset** by entering: `huggingface-cli login`. Following the instructions of that command, and it will prompt you for your Hugging Face **Access Token**.
  - Open [this link](https://huggingface.co/datasets/l1997i/DurLAR) and login to your Hugging Face account. At the top of the page, in the section **“You need to agree to share your contact information to access this dataset”**, agree to the conditions and access the dataset content. If you have already agreed and been automatically granted access, the page will display: **“Gated dataset: You have been granted access to this dataset.”**

> **Note**: The Hugging Face service may be restricted in certain countries or regions. In such cases, you may consider using a Hugging Face mirror (Hugging Face 镜像) as an alternative.

### Download the dataset using scripts (recommended)

We provide a [pre-written Bash script](durlar_hf_download_script.sh) to download the dataset from Hugging Face. You need to manually modify the **User Configuration (Modify as Needed)** section at the beginning of [durlar_hf_download_script.sh](durlar_hf_download_script.sh) to match your desired paths and features.

If you encounter any issues (e.g., network problems or unexpected interruptions), you can also modify this script to fit your needs. For example, if the extraction process is interrupted, you can manually comment out the dataset download section and resume from extraction.

### Manually download the dataset (fallback)

If the above script does not work, you can download the dataset manually. This option is only a fallback in case the script fails and is **not recommended**. 

To download all dataset files from Hugging Face, use:

```bash
huggingface-cli download l1997i/DurLAR --repo-type dataset --local-dir [YOUR_DATASET_DOWNLOAD_PATH]
```

The parameter `--local-dir` is optional. For example,

```bash
# Example 1: The recommended (and default) way to download files from the Hub is to use the cache-system, without --local-dir specified
huggingface-cli download l1997i/DurLAR --repo-type dataset

# Example 2: in some cases you want to download files and move them to a specific folder. You can do that using the --local-dir option.
huggingface-cli download l1997i/DurLAR --repo-type dataset --local-dir /home/my_username/datasets/DurLAR_tar/
```

### **Merge and Extract the Dataset**

Reassemble the .tar parts:

```bash
cd /home/my_username/datasets/DurLAR_tar/ # Enter the dataset local-dir folder. Note: Your path may be different from mine. Please adjust it accordingly.
cat DurLAR_dataset.tar* > DurLAR_dataset_full.tar
```

Extract the full dataset:

```bash
tar -xvf DurLAR_dataset_full.tar -C /your/desired/path
```

Optionally, If you have **pigz** installed, you can extract using **multi-threaded pigz** for faster speed:

```bash
which pigz # it should correctly return the path of pigz

tar --use-compress-program="pigz -p $(nproc)" -xvf DurLAR_dataset/DurLAR_dataset.tar -C /your/desired/path
```

### Cleanup (Optional)

Once extracted, delete the archive parts to free up space:

```bash
rm -rf DurLAR_tar # Note: Your path may be different from mine. Please adjust it accordingly.
```

****

**Now you will find the fully extracted DurLAR dataset in your `/your/desired/path`.**

## [Outdated] Early download options for the dataset (not recommended)

*The following methods were the early download options for the DurLAR dataset*. While they are still functional, they may suffer from drawbacks such as slow download speeds (the host server is in the UK), temporary connection bans, and lack of download resumption. Therefore, we do not recommend using these methods anymore.

Access to the complete DurLAR dataset can be requested through **one** of the following ways. 您可任选以下其中**任意**链接申请访问完整数据集。

[1. Access for the full dataset](https://forms.gle/ZjSs3PWeGjjnXmwg9) 

[2. 申请访问完整数据集](https://wj.qq.com/s2/9459309/4cdd/)


### [Outdated] Usage of the download script (not recommended)

Upon completion of the form, the download script `durlar_download` and accompanying instructions will be **automatically** provided. The DurLAR dataset can then be downloaded via the command line.

For the first use, it is highly likely that the `durlar_download` file will need to be made
executable:

``` bash
chmod +x durlar_download
```
 
By default, this script downloads the small subset for simple testing. Use the following command: 

```bash
./durlar_download
```
 
It is also possible to select and download various test drives:
```
usage: ./durlar_download [dataset_sample_size] [drive]
dataset_sample_size = [ small | medium | full ]
drive = 1 ... 5
```
 
Given the substantial size of the DurLAR dataset, please download the complete dataset
only when necessary:
```bash
./durlar_download full 5
```
 
Throughout the entire download process, it is important that your network remains
stable and free from any interruptions. In the event of network issues, please delete all
DurLAR dataset folders and rerun the download script. Currently, our script supports
only Ubuntu (tested on Ubuntu 18.04 and Ubuntu 20.04, amd64). For downloading the
DurLAR dataset on other operating systems, please refer to [Durham Collections](https://collections.durham.ac.uk/collections/r2gq67jr192) for instructions.

## CSV format for `imu`, `gps`, and `lux` topics

### Format description

Our `imu`, `gps`, and `lux` data are all in `CSV` format. The **first row** of the `CSV` file contains headers that **describe the meaning of each column**. Taking `imu` csv file for example (only the first 9 rows are displayed),

1. `%time`: Timestamps in Unix epoch format.
2. `field.header.seq`: Sequence numbers.
3. `field.header.stamp`: Header timestamps.
4. `field.header.frame_id`: Frame of reference, labeled as "gps".
5. `field.orientation.x`: X-component of the orientation quaternion.
6. `field.orientation.y`: Y-component of the orientation quaternion.
7. `field.orientation.z`: Z-component of the orientation quaternion.
8. `field.orientation.w`: W-component of the orientation quaternion.
9. `field.orientation_covariance0`: Covariance of the orientation data.

![image](https://github.com/l1997i/DurLAR/assets/35445094/18c1e563-c137-44ba-9834-345120026db0)

### Header of `csv` files

The first line of the `csv` files is shown as follows.

For the GPS, 
```csv
time,field.header.seq,field.header.stamp,field.header.frame_id,field.status.status,field.status.service,field.latitude,field.longitude,field.altitude,field.position_covariance0,field.position_covariance1,field.position_covariance2,field.position_covariance3,field.position_covariance4,field.position_covariance5,field.position_covariance6,field.position_covariance7,field.position_covariance8,field.position_covariance_type
```

For the IMU, 
```
time,field.header.seq,field.header.stamp,field.header.frame_id,field.orientation.x,field.orientation.y,field.orientation.z,field.orientation.w,field.orientation_covariance0,field.orientation_covariance1,field.orientation_covariance2,field.orientation_covariance3,field.orientation_covariance4,field.orientation_covariance5,field.orientation_covariance6,field.orientation_covariance7,field.orientation_covariance8,field.angular_velocity.x,field.angular_velocity.y,field.angular_velocity.z,field.angular_velocity_covariance0,field.angular_velocity_covariance1,field.angular_velocity_covariance2,field.angular_velocity_covariance3,field.angular_velocity_covariance4,field.angular_velocity_covariance5,field.angular_velocity_covariance6,field.angular_velocity_covariance7,field.angular_velocity_covariance8,field.linear_acceleration.x,field.linear_acceleration.y,field.linear_acceleration.z,field.linear_acceleration_covariance0,field.linear_acceleration_covariance1,field.linear_acceleration_covariance2,field.linear_acceleration_covariance3,field.linear_acceleration_covariance4,field.linear_acceleration_covariance5,field.linear_acceleration_covariance6,field.linear_acceleration_covariance7,field.linear_acceleration_covariance8
```

For the LUX,
```csv
time,field.header.seq,field.header.stamp,field.header.frame_id,field.illuminance,field.variance
```

### To process the `csv` files

To process the `csv` files, you can use multiple ways. For example,

**Python**: Use the pandas library to read the CSV file with the following code:
```python
import pandas as pd
df = pd.read_csv('data.csv')
print(df)
```

**Text Editors**: Simple text editors like `Notepad` (Windows) or `TextEdit` (Mac) can also open `CSV` files, though they are less suited for data analysis.


## Folder \#Frame Verification

For easy verification of folder data and integrity, we provide the number of frames in each drive folder, as well as the [MD5 checksums](https://collections.durham.ac.uk/collections/r2gq67jr192?utf8=%E2%9C%93&cq=MD5&sort=) of the zip files.

| Folder   | # of Frames |
|----------|-------------|
| 20210716 | 41993       |
| 20210901 | 23347       |
| 20211012 | 28642       |
| 20211208 | 26850       |
| 20211209 | 25079       |
|**total** | **145911**  |

## Intrinsic Parameters of Our Ouster OS1-128 LiDAR

The intrinsic JSON file of our LiDAR can be downloaded at [this link](os1-128.json). For more information, visit the [official user manual of OS1-128](https://data.ouster.io/downloads/software-user-manual/firmware-user-manual-v3.1.0.pdf).

Please note that **sensitive information, such as the serial number and unique device ID, has been redacted** (indicated as XXXXXXX). 

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
 keywords = {autonomous driving, dataset, high-resolution LiDAR, flash LiDAR, ground truth depth, dense depth, monocular depth estimation, stereo vision, 3D},
 category = {automotive 3Dvision},
}
```
---
