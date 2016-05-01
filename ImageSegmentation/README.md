# CV topic: Image Segmentation

## Histogram splitting
The simplest way is histogram splitting. 

Procedure:
- Compute image histogram.
- Smooth histogram.
- Look for peaks separated by deep valleys.
- Group pixels into connected regions.
- Smooth these regions.
- Iterate.

Drawbacks:
- Histograms do not account for neighborhood relationships.
- Thresholds are hard to find.
- Some edges can have gray levels on both sides that belong to the same histogram peak.

## K-means
K-means implicitly models the probability density as a superposition of spherically symmetric distributions, it does not requireany probabilistic reasoning or modeling. Instead, the algorithm is given the number of clusters `k` it is supposed to find; it then iteratively updates the cluster center location based on the samples that are closest to each center. The algorithm can be initialized by randomly sampling `k` centers from the input feature feature vectors. 

Finally, an example of K-means is given by this repository.

###K-means++ for choosing initial variables:

1. Choose one center uniformly at random from among the data points.
2. For each data point x, compute D(x), the distance between x and the nearest center that has already been chosen.
3. Choose one new data point at random as a new center, using a weighted probability distribution where a point x is chosen with probability proportional to D(x)^2.
4. Repeat Steps 2 and 3 until k centers have been chosen.
5. Now that the initial centers have been chosen, proceed using standard k-means clustering.


Although the initial selection in the algorithm takes extra time, the k-means part itself converges very quickly after this seeding.

## Gaussian Mixture
In mixtures of Gaussians, each cluster center is augmented by a covariance matrix whose values are re-estimated from the corresponding samples. Instead of using nearest neighbors to associate input samples with cluster centers, a [Mahalanobis distance](https://en.wikipedia.org/wiki/Mahalanobis_distance) is used. An EM algorithm can be used to solve this problem. 

## Mean shift
While K-means and mixtures of Gaussians use a parametric form to model the probability density function being segmented, mean shift implicitly models this distribution using a smooth continuous `non-parametric model`. The key to mean shift is a technique for efficiently finding peaks in this high-dimentional data distribution without ever computing the complete function explicitly.   

## Some Advices
Since the literature on image segmentation is so vast, a good way to get a handle on some of the better performing algorithms is to look at experimental comparisons on human-labeled databases. The best known of these is the [Berkeley Segmentation Dataset and Benchmark](http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/segbench/), which consists of 1000 images from a Corel image dataset that were hand-labeled by 30 human subjects. 
