sudo dnf install -y python3.12 python3.12-devel

rm -rf python openpyxl-layer.zip
mkdir python

python3.12 -m pip install --upgrade pip
python3.12 -m pip install openpyxl -t python/

zip -r openpyxl-layer.zip python
