# Secured-Data-Transmission-SenderEnd-ReceiverEnd-With-Steganography--Image-hidden-in-Image--With-GUI.

Implementation of several algorithms including AES, 
RSA, SHA-256, PVD Steganography Algorithm, and many 
more for the creation of separate sender end and receiver 
end programs using which they can securely communicate. 
GUI implementation has been done for the ease of access. 
This project ensures CIA in Network Security and has been 
implemented in MATLAB 2019b.

%IMPORTANT%

Inorder to Understand the Whole Process, First go through 
the "WorkingProcedure.docx" file to get the basic understanding.

#How to Use (Sender Side):

Step 1: Open MATLAB 2019b.

Step 2: Navigate to "Apps" tabs in MATLAB 
Toolbar.

Step 3: Open "SenderSide.mlapp".

Step 4: Run "SenderSide.mlapp" and GUI will 
start.

Step 5: Click First Generate Button to generate 
public key and private key values for Sender and 
Receiver End and then generate Values of X and Y.

Step 5: GUI is self-explanatory. Ensure to check 
the "Image" check box and select the image file (prefer 64x64 pixel image)
and click on Generate button to encrypt the image in CBC manner 
and in Overall encrypted manner and the encrypted image will be available as
"encrypted.bmp". (Will take upto 1 minute for 64x64 pixel 
input image, Have Patience)

Step 6: Generate Digital Hash and Digital Signature.

Step 7: Click "Select the cover Image" (Eg: PVD_baboon.bmp)

Step 8: Click "Create Stego Image" and the stego image will 
be generated and saved as "PVD_stego_image.bmp" and also 
you can calculate PSNR Value. Note: Created Stego Image will encapsulate
input image in encrypted manner. "encrypted.bmp" is for reference only.

#How to Use (Receiver Side):

Step 1: Open MATLAB 2019b.

Step 2: Navigate to "Apps" tabs in MATLAB Toolbar.

Step 3: Open "ReceiverSide.mlapp".

Step 4: Run "ReceiverSide.mlapp" and GUI will start.

Step 5: Click "Select Stego Image" and select the previously 
generated "PVD_stego_image.bmp".

Step 6: Check "Image" checkbox and click "Extract" (Will take upto 1 minute, 
Have patience).

Step 7: Click the consecutive "Decrypt" buttons and the input 
image will be recovered and will be available as "decrypted.bmp"

Step 8: Integrity can be verified by comparing the digests.

