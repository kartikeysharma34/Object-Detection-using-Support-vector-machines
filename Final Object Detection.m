clc
clear all


Dataset = 'G:\trainingSet';  
Testset  = 'G:\testSet';


width=100; height=100;
DataSet = cell([], 1);

 for i=1:length(dir(fullfile(Dataset,'*.jpg')))

    
     k = dir(fullfile(Dataset,'*.jpg'));
     k = {k(~[k.isdir]).name};
     for j=1:length(k)
        tempImage       = imread(horzcat(Dataset,filesep,k{j}));
        imgInfo         = imfinfo(horzcat(Dataset,filesep,k{j}));

         
         if strcmp(imgInfo.ColorType,'grayscale')
            DataSet{j}   = double(imresize(tempImage,[width height])); % array of images
         else
            DataSet{j}   = double(imresize(rgb2gray(tempImage),[width height])); % array of images
         end
     end
 end
TestSet =  cell([], 1);
  for i=1:length(dir(fullfile(Testset,'*.jpg')))

     
     k = dir(fullfile(Testset,'*.jpg'));
     k = {k(~[k.isdir]).name};
     for j=1:length(k)
        tempImage       = imread(horzcat(Testset,filesep,k{j}));
        imgInfo         = imfinfo(horzcat(Testset,filesep,k{j}));

         
         if strcmp(imgInfo.ColorType,'grayscale')
            TestSet{j}   = double(imresize(tempImage,[width height])); % array of images
         else
            TestSet{j}   = double(imresize(rgb2gray(tempImage),[width height])); % array of images
         end
     end
  end

  
train_label               = zeros(size(30,1),1);
train_label(1:15,1)   = 1;         % 1 = Faces
train_label(16:30,1)  = 2;         % 2 = Airplanes


Training_Set=[];
for i=1:length(DataSet)
    Training_Set_tmp   = reshape(DataSet{i},1, 100*100);
    Training_Set=[Training_Set;Training_Set_tmp];
end

Test_Set=[];
for j=1:length(TestSet)
    Test_set_tmp   = reshape(TestSet{j},1, 100*100);
    Test_Set=[Test_Set;Test_set_tmp];
end


SVMStruct = svmtrain(Training_Set , train_label, 'kernel_function', 'linear');
Group       = svmclassify(SVMStruct, Test_Set);