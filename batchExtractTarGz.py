#!python
import os
import tarfile
import fire
from alive_progress import alive_bar

def batch_extract_tar_gz(folder_path):
    '''
    批量解压 tar.gz 文件，并在调用位置创建同名文件夹，并将文件解压至同名文件夹中
    '''
    total_bars = len(os.listdir(folder_path))
    with alive_bar(total_bars, title="解压进度:") as bar:
        for file in os.listdir(folder_path):
            if file.endswith('.tar.gz'):
                with tarfile.open(os.path.join(folder_path, file), 'r:gz') as tar:
                    target_folder = os.path.splitext(file)[0]
                    os.makedirs(target_folder, exist_ok=True)
                    tar.extractall(target_folder)
            bar()

if __name__ == '__main__':
    fire.Fire(batch_extract_tar_gz)