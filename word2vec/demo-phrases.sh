{\rtf1\ansi\ansicpg1252\cocoartf1265\cocoasubrtf190
{\fonttbl\f0\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720

\f0\fs24 \cf0 make\
if [ ! -e news.2012.en.shuffled ]; then\
  wget http://www.statmt.org/wmt14/training-monolingual-news-crawl/news.2012.en.shuffled.gz\
  gzip -d news.2012.en.shuffled.gz -f\
fi\
sed -e "s/\'e2\'80\'99/'/g" -e "s/\'e2\'80\'b2/'/g" -e "s/''/ /g" < news.2012.en.shuffled | tr -c "A-Za-z'_ \\n" " " > news.2012.en.shuffled-norm0\
time ./word2phrase -train news.2012.en.shuffled-norm0 -output news.2012.en.shuffled-norm0-phrase0 -threshold 200 -debug 2\
time ./word2phrase -train news.2012.en.shuffled-norm0-phrase0 -output news.2012.en.shuffled-norm0-phrase1 -threshold 100 -debug 2\
tr A-Z a-z < news.2012.en.shuffled-norm0-phrase1 > news.2012.en.shuffled-norm1-phrase1\
time ./word2vec -train news.2012.en.shuffled-norm1-phrase1 -output vectors-phrase.bin -cbow 1 -size 200 -window 10 -negative 25 -hs 0 -sample 1e-5 -threads 20 -binary 1 -iter 15\
./distance vectors-phrase.bin\
}