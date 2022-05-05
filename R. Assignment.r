# Install required packages
install.packages(c("tm", "wordcloud","SnowballC"))

# Load libraries
library(tm)
library(wordcloud)
library(SnowballC)


wp_content1 <- read.csv("nycairbnb.csv")



docs<-Corpus(VectorSource(wp_content1))
# Strip unnecessary whitespace
docs <- tm_map(docs, stripWhitespace)
# Convert to lowercase
docs <- tm_map(docs, tolower)
# Remove conjunctions etc.
docs <- tm_map(docs,removeWords, stopwords("english"))
# Remove suffixes to the common 'stem'
docs <- tm_map(docs, stemDocument)
# Remove commas etc.
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)

#(optional) arguments of 'tm' are converting the document to something other than text, to avoid, run this line
#mooncloud <- tm_map(mooncloud, PlainTextDocument)



wordcloud(docs
          , scale=c(10, 0.2)     # Set min and max scale
          , max.words=100      # Set top n words
          , random.order=FALSE # Words in decreasing freq
          , rot.per=0.35       # % of vertical words
          , use.r.layout=FALSE # Use C++ collision detection
          , colors=brewer.pal(12, "Dark2"))
           title(main = "Word Map of Airbnb data of NYC ", sub = "Source: airbnb, 2019")


#
wordcloud(words = docs$word, freq = docs$freq, min.freq = 1, max.words=200, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))           
           
#

docs <- tm_map(docs, function(x) stri_replace_all_regex(x, "<.+?>", " "))
docs <- tm_map(docs, function(x) stri_replace_all_fixed(x, "\t", " "))

docs <- tm_map(docs, PlainTextDocument)
# remove punctuation
docs <- tm_map(docs, removePunctuation)
# remove numbers and symbols
docs <- tm_map(docs, removeNumbers)
# set capital letters to lower letters
docs <- tm_map(docs, content_transformer(tolower)) 
# remove common words ("the", "and")
docs <- tm_map(docs, removeWords, stopwords("english"))
# stem the document
docs <- tm_map(docs, stemDocument)
# remove white spaces between sentences
docs <- tm_map(docs, stripWhitespace)

#
docs[[1]]$content
dtm<-DocumentTermMatrix(docs)
tdm<-TermDocumentMatrix(docs)

dtm # 541 words from this page of wikipedia on 'Data Science'. 
tdm

mywords<-dtm$dimnames$Terms
mywords
#
m <- as.matrix(dtm)
v <- sort(colSums(m), decreasing=TRUE)
myNames <- names(v)
dtmnew <- data.frame(word=myNames, freq=v)
wordcloud(dtmnew$word, colors=c(3,4), random.color=TRUE, dtmnew$freq, min.freq=5)












mooncloud2 <- Corpus(read.csv("nycairbnb.csv"))


mooncloud1 <- Corpus(mooncloud)
# Strip unnecessary whitespace
mooncloud <- tm_map(mooncloud, stripWhitespace)
# Convert to lowercase
mooncloud <- tm_map(mooncloud, tolower)
# Remove conjunctions etc.
mooncloud <- tm_map(mooncloud, removeWords, stopwords("english"))
# Remove suffixes to the common 'stem'
mooncloud <- tm_map(mooncloud, stemDocument)
# Remove commas etc.
mooncloud <- tm_map(mooncloud, removePunctuation)

#(optional) arguments of 'tm' are converting the document to something other than text, to avoid, run this line
mooncloud <- tm_map(mooncloud, PlainTextDocument)
