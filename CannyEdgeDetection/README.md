# Canny Edge Detection by Matlab

Canny edge detector was developed in 1980s and since then it is one of the most popular edge detection techniques. It satisfies three conditions for a good edge detector, which are:
```javascript
• Low error rate: meaning a good detection of only existent edges.
• Good localization: the distance between edge pixels detected and real edge pixels
has to be minimized.
• Minimal response: only one detector response per edge.
```
In this exercise session we will implement and test Canny edge detector from scratch, by following five steps described below. These are:
```
1. Preprocessing - filtering out the noise
2. Computing gradient - magnitude and direction 
3. Non-maxima supression
4. Double thresholding
5. Hysterisis thresholding
```
