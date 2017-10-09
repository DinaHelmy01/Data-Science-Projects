function main()

%Reading the image and performing quantization on different bit rates
%Then plotting a graph; Quantization bits and the mse error in each case

I=imread('lena.jpg');
Error1=Quantizer_d(I,8)
Error2=Quantizer_d(I,16)
Error3=Quantizer_d(I,64)
Error4=Quantizer_d(I,85)

Quantizaion_Bits=[ceil(log2(8)),ceil(log2(16)),ceil(log2(64)),ceil(log2(85))]
error=[Error1,Error2,Error3,Error4]

figure
plot(Quantizaion_Bits,error,'-x')
xlabel('Quantizaion Bits')
ylabel('Distortion ')

end