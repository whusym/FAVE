function [covarep_path] = initcovarep()
	%initalizes covarep
	covarep_path = [pwd '/bin/covarep']

	addpath(genpath(covarep_path));
	rmpath(genpath([covarep_path '/.git']));
	rmpath(genpath([covarep_path '/documentation']));

	addpath([covarep_path '/glottalsource/creaky_voice_detection/private'])

	pkg load all
