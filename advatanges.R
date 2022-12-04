Advantages


History matching works by iteratively discounting values of the active input parameters as implausible give measurements and relevant uncertainties, and then retraining sets of emulators which focus on predicting well in the non-implausible design space, known as 'refocussing'. In order to describe it in more detail, we now develop our mathematical notation further. 


Curse of dimensionality is not an issue. ML has the problem of ensuring we find a local maximum, MCMC requires finding stationary distribution which requires a great many samples especially in high-dimensional space. In history matching, the problem is turned on it's head as all we need to know about a sample is it is not likely to give a good match to measurements. Problems with high dimensionality will manifest in simulator variance, increasing the uncertainty in the system making us unlikely to discard proposals that we don't know much about (because we are emualting far away from them). So it is unlikely that proposals will be thrown anway until we know enoough about them (that is, emulate with a similar training point). The trainiing point only needs to be 'close' in important dimensions, thanks to the information encoded in the Gaussian process correlation lengths.



History matching can be used to try and find values of TALYS active input parameters which could give good agreement with the true cross-sections. The assumption is that if, for some values of the active input parameters, good agreement can be found between simulation and the measurements, the same input parameters will allow TALYS to  give good predictions for processes which have not been measured. This is pertinent for TALYS, because some processes of the processes it simulates are almost impossible to measure. 

