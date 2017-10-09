function Error=Quantizer_d(Image, Quantizaion_Levels)

%This code performs a dynamic quantization based on the max and min pixel 
%intensity in the Image. Also, the Quantization levels should be given as 
%an argument. The output is the mse error between the original image and
%the quantized image


%Example of input Quantizer(I,16),Quantizer(I,256),Quantizer(I,16)

Maximum= double(max(max(Image)));
Minimum= double(min(min(Image)));
Step =  ceil( ((Maximum)+1-(Minimum)) /(Quantizaion_Levels) );

%Creating the steps starting from the min value of the image, till the max
%value
last_value=Quantizaion_Levels*Step
if(last_value<= double(Maximum))
    last_value=double(Maximum)+1;
end
B=[];
for i =  Minimum:Step:last_value %this should include all the numbers in the range not ony till 256
    B = [B ;i];
end 

%Creating the codebook
CodeBook = [] ;
for i =  1:length(B)-1
    temp=B(i):1:B(i+1)-1;
    temp(temp > Maximum )=NaN;
    %If values are bigger than the max value in the matrix, replace it with NaN
    CodeBook = [ CodeBook; [ (B(i)+B(i+1))/2 , temp]] ;
end 
    
%Creating the quantized image
J=[];
Error=0.0;
for i = 1:size(Image,1)
    for j = 1:size(Image,2)
      [r c]=find(CodeBook==Image(i,j));
        J(i,j)= CodeBook(r(1),1);
        %Calculating the mse/Distortion
        Error = Error + (double(Image(i,j)) - double(J(i,j)))^2 ;
    end
end


[r,c]=size(Image)
Error=Error/(r*c)

Result_Image = mat2gray(J);
figure
imshow(Result_Image);

end


