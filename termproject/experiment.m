clc
clear all
close all
D=5;
N=100000000;

testData = load('testData005.distances');
nBins = 40;
[dnnHist, dnnBins] = hist(testData(:,1), nBins);
[danyHist, danyBins] = hist(testData(:,2), nBins);

clear results
for r=0:2
    results(r+1) = CalculateLSHParameters( N, dnnHist, dnnBins, danyHist, danyBins);
end

fprintf('Multiprobe R'); 
fprintf('%10g ', [results(:).multiprobeR]); fprintf('\n');
fprintf('Exact W:    '); 
fprintf('%10g ', [results(:).exactW]); fprintf('\n');
fprintf('Exact k:    '); 
fprintf('%10g ', [results(:).exactK]); fprintf('\n');
fprintf('Exact L:    '); 
fprintf('%10g ', [results(:).exactL]); fprintf('\n');
fprintf('Exact Cost: '); 
fprintf('%10g ', [results(:).exactCost]); fprintf('\n');