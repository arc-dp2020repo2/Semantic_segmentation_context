function [allImgList, testImgIdx] = genTrainTestListSIFT(imgFold,matFold)
% generate training/test image lists.

allImgList = dir_recurse(fullfile(imgFold,'*.jpg'),0);

if exist(([matFold 'testImgIdxCV.mat']),'file')
    load([matFold 'testImgIdxCV.mat'],'testImgIdx');
else 
    testImgListCell = textread([imgFold 'TestSet1.txt'],'%s');
    [idx locat] = ismember(testImgListCell,allImgList);
    testImgIdx = locat';
    
    save([matFold 'testImgIdxCV.mat'],'testImgIdx');
end

