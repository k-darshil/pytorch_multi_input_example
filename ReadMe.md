# Multi-Input Deep Neural Networks with PyTorch-Lightning - Combine Image and Tabular Data

![Input image.](teaser.png)

## Overview

This project demonstrates how to create a multi-input deep neural network using PyTorch Lightning that combines both image and tabular data to predict real estate prices. The model takes house images and property features (latitude, longitude, beds, baths, area) as inputs and predicts house prices using regression.

One of the most significant advantages of artificial deep neural networks has always been that they can pretty much take any kind of data as input and can approximate a non-linear function to predict on that data. This tutorial shows you how to use `PyTorch Lightning` to predict real estate prices of houses through matching image data and tabular information.

[You can find the sample data sets used here](https://1drv.ms/u/s!AqUPqx8G81xZiL1l80RtZbjPj43MhA?e=KagzKc). The full tutorial is available through my [blog](https://rosenfelder.ai/multi-input-neural-network-pytorch/).

## Features

- **Multi-Input Architecture**: Combines CNN for image processing and fully connected layers for tabular data
- **PyTorch Lightning**: Clean, organized, and scalable deep learning code
- **Real Estate Price Prediction**: Practical application using house images and property features
- **Data Preprocessing**: Comprehensive pipeline for cleaning and preparing multi-modal data
- **Early Stopping**: Prevents overfitting with automatic training termination
- **TensorBoard Integration**: Real-time training monitoring and visualization

## Project Structure

```
├── pytorch_lightning_regression.py          # Main training script with multi-input model
├── pytorch_lightning_regression_image_only.py  # Image-only baseline model
├── preprocessing.py                         # Data preprocessing pipeline
├── requirements.txt                        # Project dependencies
├── teaser.png                              # Project visualization
├── ReadMe.md                               # This file
└── data/                                   # Data directory (not included)
    ├── images/                             # Raw house images
    ├── processed_images/                   # Resized images (224x224)
    ├── ny_dataframe.pkl                    # Raw tabular data
    └── df.pkl                              # Processed tabular data
```

## Installation

### Requirements

- Python 3.7+
- CUDA-capable GPU (optional but recommended)

### Setup

1. Clone this repository:
```bash
git clone <repository-url>
cd <repository-name>
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Download the dataset from the provided link and extract to `./data/` directory

## Usage

### Data Preprocessing

First, prepare your data by running the preprocessing script:

```bash
python preprocessing.py
```

This script will:
- Filter tabular data to include only rows with corresponding images
- Resize images to 224x224 pixels
- Remove outliers from numerical features
- Save processed data as pickle files

### Training the Model

#### Multi-Input Model (Image + Tabular)
```bash
python pytorch_lightning_regression.py
```

#### Image-Only Baseline
```bash
python pytorch_lightning_regression_image_only.py
```

### Model Architecture

The multi-input model consists of:

**Image Processing Branch:**
- 3 Convolutional blocks (Conv2D → ReLU → BatchNorm → MaxPool)
- Progressive channel expansion: 3 → 16 → 32 → 64
- Flattening and fully connected layers

**Tabular Processing Branch:**
- Fully connected layers processing 5 features:
  - Latitude
  - Longitude
  - Number of bedrooms
  - Number of bathrooms
  - Area

**Fusion Layer:**
- Concatenation of image and tabular features
- Final regression layer for price prediction

### Training Configuration

- **Loss Function**: L1 Loss (Mean Absolute Error)
- **Optimizer**: Adam
- **Learning Rate**: Automatically determined using PyTorch Lightning's learning rate finder
- **Early Stopping**: Monitors validation loss with patience=7
- **Data Split**: 80% train, 10% validation, 10% test

## Key Dependencies

- `pytorch-lightning==0.8.5` - High-level PyTorch framework
- `torch==1.5.1+cu101` - PyTorch with CUDA support
- `torchvision==0.6.1+cu101` - Computer vision utilities
- `pandas==1.0.5` - Data manipulation
- `Pillow==8.3.2` - Image processing
- `numpy==1.19.0` - Numerical computing
- `matplotlib==3.3.0` - Plotting and visualization

## Model Performance

The model uses L1 Loss (Mean Absolute Error) for training and evaluation. Training includes:
- Automatic learning rate finding
- Early stopping to prevent overfitting
- TensorBoard logging for monitoring
- Validation and test set evaluation

## Data Format

### Tabular Data Expected Columns:
- `zpid`: Property ID (used for image matching)
- `price`: Target variable (house price)
- `latitude`: Property latitude
- `longitude`: Property longitude
- `beds`: Number of bedrooms
- `baths`: Number of bathrooms
- `area`: Property area

### Image Data:
- Format: PNG files
- Naming: `{zpid}.png`
- Input size: 224x224 pixels (automatically resized)
- Channels: RGB (3 channels)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available under the MIT License. See the LICENSE file for more details.

## Acknowledgments

- Original tutorial and blog post: [rosenfelder.ai](https://rosenfelder.ai/multi-input-neural-network-pytorch/)
- PyTorch Lightning framework for clean ML code organization
- Real estate dataset for practical application demonstration

## Contact

For questions and support, please refer to the original blog post or create an issue in this repository.
