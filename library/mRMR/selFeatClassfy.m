function selFeatClassfy(dataDir,selFeatType,selFeatLen,selEmoNum,featFusionFlag,Result)

load([dataDir selFeatType 'Feat.mat'], 'pointFeat', 'emotionFlag');

% feature with decreasing numbers.
 trainDiscretFeat = dataDiscret(single(pointFeat));
% return the first K important features. Thus, it can directly
% used for testing performance with different features.
 selFeaIdx = mrmr_miq_d(double(trainDiscretFeat), emotionFlag, selFeatLen);
 save([dataDir selFeatType 'SelFeaIdxMIQ.mat'],'selFeaIdx');

% load([dataDir selFeatType 'SelFeaIdxMIQ.mat'],'selFeaIdx');
[trainNormFeat, sta]  = normalizeX(double(pointFeat'));
trainNormFeat = trainNormFeat(selFeaIdx(:),:);
if featFusionFlag==1
    load([dataDir 'FAPFeat.mat'],'FAPFeat');
    [trainNormFeatFAP, sta]  = normalizeX(double(FAPFeat'));
    trainNormFeat = [trainNormFeat; trainNormFeatFAP];
    clear trainNormFeatFAP FeatFAP sta;
end

if featFusionFlag==0
    if Result == 1   % probability
        Model  = svmtrain(double(emotionFlag),trainNormFeat','-t 2 -b 1');
        save([dataDir 'TrainedSVMProbModel_' selFeatType num2str(selEmoNum) 'Emo.mat'], 'Model');
    else     % classification
        Model  = svmtrain(double(emotionFlag),trainNormFeat','-t 2');
        save([dataDir 'TrainedSVMModel_' selFeatType num2str(selEmoNum) 'Emo.mat'], 'Model');
    end
else
    if Result == 1   % probability
        Model  = svmtrain(double(emotionFlag),trainNormFeat','-t 2 -b 1');
        save([dataDir 'TrainedSVMProbModel_' selFeatType 'FAP' num2str(selEmoNum) 'Emo.mat'], 'Model');
    else     % classification
        Model  = svmtrain(double(emotionFlag),trainNormFeat','-t 2');
        save([dataDir 'TrainedSVMModel_' selFeatType 'FAP' num2str(selEmoNum) 'Emo.mat'], 'Model');
    end
end
    





