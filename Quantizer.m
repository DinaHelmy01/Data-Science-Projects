function I = Quantizer(Image, Quantizaion_Levels)
 
%This code performs a scalar quantization for the Image. Also, the 
%Quantization levels should be given as an argument



%Example of input Quantizer(I,16),Quantizer(I,256),Quantizer(I,16)

Step = ceil(256 / Quantizaion_Levels);

%Creating the steps
B=[];
for i =  0:Step:256+Step %this should include all the numbers in the range not ony till 256
    B = [B ;i];
end

%Creating the codebook
CodeBook = []
for i =  1:length(B)-1
    temp=B(i):1:B(i+1)-1;
    temp(temp > 255 )=NaN;
    %If values are bigger than 256 in the matrix, replace it with
    %NaN
    CodeBook = [ CodeBook; [ (B(i)+B(i+1))/2 ,temp]]  ;  
end

%Creating the quantized image
J=[];
for i = 1:size(Image,1)
    for j = 1:size(Image,2)
      [r c]=find(CodeBook==Image(i,j));
        J(i,j)= CodeBook(r(1),1);
    end
end

%Change the image to RGB and show it
Result_Image = mat2gray(J);
imshow(Result_Image);



end


