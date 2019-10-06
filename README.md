# Flask-ML-Application
A deployable Flask based ML application

### needs
> * create a [vertual environment](https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/) in python.
> * or if you have conda base it's ok to work directly.
> * activate the virtual environment.

### installing the required libraries
```bash
pip install -r requirements.txt
```

### Running Flask App
```bash
export FLASK_APP=app.py
flask run
```

### usage
* initially user need to signup for the app or login if already signedup
![login image](/images/scrn1.png)
![signup image](/images/scrn2.png)
* then user select the 10 stocks.
![select image](/images/scrn3.png)
* then based on useres selection the predictions are made
![predict image](/images/scrn4.png)
