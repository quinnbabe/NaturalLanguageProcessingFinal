{\rtf1\ansi\ansicpg1252\cocoartf1265\cocoasubrtf190
{\fonttbl\f0\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720

\f0\fs24 \cf0 make\
if [ ! -e text8 ]; then\
  wget http://mattmahoney.net/dc/text8.zip -O text8.gz\
  gzip -d text8.gz -f\
fi\
echo ---------------------------------------------------------------------------------------------------\
echo Note that for the word analogy to perform well, the model should be trained on much larger data set\
echo Example input: paris france berlin\
echo ---------------------------------------------------------------------------------------------------\
time ./word2vec -train text8 -output vectors.bin -cbow 1 -size 200 -window 8 -negative 25 -hs 0 -sample 1e-4 -threads 20 -binary 1 -iter 15\
./word-analogy vectors.bin\
}