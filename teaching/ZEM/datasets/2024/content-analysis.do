
***** STEP 1: install libraries
*** use pip install to install python libraries (pandas nltk) 
*** shell allows you to send commands to your operating system

shell pip install pandas nltk


***** Step 2: Call python and verify it works

python
print("Hello world")


###### Step 3: load libraries

import pandas as pd
import nltk
nltk.download('all')
from nltk.sentiment.vader import SentimentIntensityAnalyzer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer


##### Step 4: load data

df = pd.read_csv('sotu_text.csv')
### Check data
df

### Turn data into list
number_list = df['number'].tolist()
speeches_list = df['x'].tolist()

### Check first entry in list [0]
print(speeches_list[0])


###### Step 5: Clean first speech [0] 

### Create tokens (token is a word)
tokens = word_tokenize(speeches_list[0].lower())

### Check what you created
print(tokens)

### Remove stop words (words like "a" and "the" that are not important)
filtered_tokens = [token for token in tokens if token not in stopwords.words('english')]

### Check what you removed
print(filtered_tokens)

### Lematize tokens (find base of each word)
lemmatizer = WordNetLemmatizer()
lemmatized_tokens = [lemmatizer.lemmatize(token) for token in filtered_tokens]

### Check what lematizer did
print(lemmatized_tokens)

### join tokens back together
processed_text = ' '.join(lemmatized_tokens)

### Check your final product
print(processed_text)


##### Step 6: Analyze first speech

analyzer = SentimentIntensityAnalyzer()
scores = analyzer.polarity_scores(processed_text)

### Check scores 
print(scores)


##### Step 7: that is the basic process, now you need to do the other 200+ speeches
### USE a loop
### Check number of speeches
list_count = len(number_list)
print(list_count)

### loop to process text
# create empty list to add clean text 
processed_list = []

# Set up loop

for x in range(list_count):
	tokens = word_tokenize(speeches_list[x].lower())
	filtered_tokens = [token for token in tokens if token not in stopwords.words('english')]
	lemmatizer = WordNetLemmatizer()
	lemmatized_tokens = [lemmatizer.lemmatize(token) for token in filtered_tokens]
	processed_text = ' '.join(lemmatized_tokens)
    ##### Add clean text to list
	processed_list.append(processed_text)


### loop to analyze text
analyzer = SentimentIntensityAnalyzer()

# create empty list to add scores
neg_list = []
pos_list = []
neu_list = []
comp_list = []

# Set up loop
for x in range(list_count):
	scores = analyzer.polarity_scores(processed_list[x])
	neg_list.append(scores['neg'])
	pos_list.append(scores['pos'])
	neu_list.append(scores['neu'])
	comp_list.append(scores['compound'])


##### Step 8: Organize and save data
### Create list of lists and turn back to data frame
new_list = [list(x) for x in zip(number_list, neg_list, pos_list, neu_list, comp_list)]
df = pd.DataFrame(new_list, columns=['count', 'neg', 'pos', 'neu', 'comp'])


### Save data as csv and end python
df.to_csv('sentiment.csv') 

end
	
	
