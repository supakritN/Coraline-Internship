# Tutorial
## Python Script
#### requirement
- python

#### at ex2/ directory

Step1: create a virtual environment
```
python -m venv .venv
```
or
```
python3 -m venv .venv
```

Step2: activate virtual environment

mac
```
source .venv/bin/activate
```
window
```
source .venv/Scripts/activate
```

Step3: install libary from requirements.txt 
``` 
pip install -r requirements.txt
```

Step4: run the python_script.py (This command will create 20 rows as a default)
``` 
python python_script.py
```
If you want to change the number of output to others. Change the \<number of output> to the number you like.
``` 
python python_script.py --size <number of output>
```
If you want to change the destination of the output. Change the \<path to saved> to the path you like.
- note that the \<path to saved> should be in "file.csv" or others for saving the dataframe and not be the directory.  
``` 
python python_script.py --size <number of output> --path <path to saved>
```