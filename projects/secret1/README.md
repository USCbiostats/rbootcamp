---
title: Breaking the code I
keywords: [strings, programming, unuseful]
difficulty: medium
---

The following message has been intercepted.

```
bv lvcnumecv (ixe tvcnemec)
gr suwbeiv avccv

avcv wbsunvcfe ne iu, 
swr v zdbiusvc bv iueccv, 
em ebbv epaecw emzwmicvc, 
cefenuw avcv fu aemv. 
vodu abvmivce eb cwpvb, 
ne bvp epaumvp fvp tcdepvp, 
iemnce bupiv bv zwcwmv, 
avcv zdvmnw em fu ie fdecvp. 

avcv fu icupiejv suwbeiv vjdb, 
zbvsebumv cwlv av' fu avpuwm, 
r avcv pvgec pu fe zwccepawmne, 
nepxwlw dm gbvmzw fvmjvmubbwm. 
pu fe oduece fdzxw, awoduiw w mvnv, 
icvmodubw odenv fu zwcvjwm. 

zcezuemnw ucv awzw v awzw, 
bwp vbetcep aempvfuemiwp, 
zdvmnw rv epiem kbwcezunwp, 
ucvm belwp id cezdecnwp. 
ne bv kbwc ne bv vfvawbv, 
pece pd felwc vfutv, 
bv awmnce gvlw bv vbfwxvnv, 
avcv nwcfucfe icvmodubv.
```

Your mission: use your R-skills to manipulate the text and decode the message.
To do so, you should use the following dictionary that our field agents have
found.

```
dict <-
c("v", "g", "z", "n", "e", "k", "t", "x", "u", "l", "h", "b", 
"f", "m", "w", "a", "o", "c", "p", "i", "d", "s", "y", "q", "r", 
"j", " ", ",", ".", "'", "(", ")")
```

Where the first 26 elements can be mapped to the 26 letters of the Roman alphabet.
The remainder should be taken as is.