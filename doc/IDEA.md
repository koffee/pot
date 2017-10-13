- k=32
- fastmap for distance
- resovoir sampler
- fft trees: one per cluster. me versus the rest.
      - if conflct, take biggest
- initial data ranodmizer (collect mins, maxes here)
- mini-batch k-means, collecting N=2 most distant points
     - x= first
     - west = furtherest from east. if ever changes, recomputer east
     - east = fuurthest from west
     - anomaly if > 15*c* d(esat,west) via fayola's algorithm (or whatever fayola's rule is)

easier supervised binner
- bins with a next pointer
- if b[i+1] same as b[i] (hedges), then the place [i] with i+i+1
- else, got to i+1

