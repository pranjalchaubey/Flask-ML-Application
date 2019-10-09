# Technical Analysis
from ta import *

def ma_score(df, n_fast, n_slow):  
    '''
    Classify EMA Crossover trend as -1 or 1.
    -1 = Sell = fast EMA crossing below slow EMA
    1 = Buy  = fast EMA crossing above slow EMA
    
    periods: 20, 50
    '''

    EMA_fast = f'EMA_{n_fast}'
    EMA_slow = f'EMA_{n_slow}'
    df[EMA_fast] = df['close'].ewm(span=n_fast, adjust=False).mean()
    df[EMA_slow] = df['close'].ewm(span=n_slow, adjust=False).mean()
    
    df['MA_score'] = 0
    
    # Sell
    df.loc[(df[EMA_fast] < df[EMA_slow]), 'MA_score'] = -1
    # Buy
    df.loc[(df[EMA_fast] >= df[EMA_slow]), 'MA_score'] = 1

    
    return df

def rsi_score(df, period):
    """
    Classify the RSI momentum as -1, 0 or 1.
    -1 = Sell = rsi > 70.0
    0 = Hold = 30.0 < rsi < 70 
    1 = Buy  = rsi < 30.0
    
    period = 14

    Adjustments
    -----------

    Temporarily assigned different period and thresholds to trigger more signals. 
    period = 10
    lo_thrsh = 45.0
    hi_thrsh = 55.0    

    """
    
    lo_thrsh = 45.0
    hi_thrsh = 55.0
    
    df['RSI_score'] = 0
    
    df['RSI'] = rsi(df['close'], period)
    
    # Buy
    df.loc[(df['RSI'] <= lo_thrsh), 'RSI_score'] = 1
    # Sell
    df.loc[(df['RSI'] >= hi_thrsh), 'RSI_score'] = -1
    
    return df

def bollinger_score(df, period, ndev):
    rolling_mean = df['close'].rolling(period).mean()
    rolling_std = df['close'].rolling(period).std()
    
    df['BB_hi'] = rolling_mean + (rolling_std * ndev)
    df['BB_lo'] = rolling_mean - (rolling_std * ndev)
    
    df['BB_score'] = 0
    
    for row in range(len(df)):
        # Sell
        if (df['close'].iloc[row] > df['BB_hi'].iloc[row]) and (df['close'].iloc[row-1] < df['BB_hi'].iloc[row-1]):
            df['BB_score'].iloc[row] = -1
        # Buy
        if (df['close'].iloc[row] < df['BB_lo'].iloc[row]) and (df['close'].iloc[row-1] > df['BB_lo'].iloc[row-1]):
            df['BB_score'].iloc[row] = 1
    
    
    return df

def classify_scores(df):
    
    df['target'] = df[['RSI_score', 'MA_score', 'BB_score', 'ret_score']].sum(axis=1)

    # Logic part for results > 1 or < -1
    a = np.array(df['target'].values.tolist())
    df['target'] = np.where(a > 1, 1, a).tolist()
    df['target'] = np.where(a < -1, -1, a).tolist()
    
    return df
