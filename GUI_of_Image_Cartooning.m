function varargout = GUI_of_Image_Cartooning(varargin)
% GUI_OF_IMAGE_CARTOONING MATLAB code for GUI_of_Image_Cartooning.fig
%      GUI_OF_IMAGE_CARTOONING, by itself, creates a new GUI_OF_IMAGE_CARTOONING or raises the existing
%      singleton*.
%
%      H = GUI_OF_IMAGE_CARTOONING returns the handle to a new GUI_OF_IMAGE_CARTOONING or the handle to
%      the existing singleton*.
%
%      GUI_OF_IMAGE_CARTOONING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OF_IMAGE_CARTOONING.M with the given input arguments.
%
%      GUI_OF_IMAGE_CARTOONING('Property','Value',...) creates a new GUI_OF_IMAGE_CARTOONING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_of_Image_Cartooning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_of_Image_Cartooning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_of_Image_Cartooning

% Last Modified by GUIDE v2.5 11-Apr-2019 03:50:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_of_Image_Cartooning_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_of_Image_Cartooning_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_of_Image_Cartooning is made visible.
function GUI_of_Image_Cartooning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_of_Image_Cartooning (see VARARGIN)

% Choose default command line output for GUI_of_Image_Cartooning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_of_Image_Cartooning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_of_Image_Cartooning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes2)
cla(handles.axes8)
%delete(allchild(handles.axes2))
global a
global aaaaa
[Filename, Pathname] = uigetfile({'*.jpg; *.JPG; *.jpeg; *.JPEG; *.png; *.img; *.IMG; *.tif; *.TIF; *.tiff, *.TIFF'},'File Selector');
name = strcat(Pathname, Filename);
a = imread(name);
aaaaa = a;
axes(handles.axes1);
imshow(a);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a
A = (a);

%Resize Image
rgb = imresize(A,[400 NaN]);
axes(handles.axes1);
imshow(rgb);

%RGB to LAB conversion
lab = rgb2lab(rgb);

%Prewitt Masking on Lab Image
kernelver = [ -1 -1 -1 ; 0 0 0 ; 1 1 1];
filteredver = imfilter(lab,kernelver);

kernelhor = [ -1 0 1 ; -1 0 1 ; -1 0 1];
filteredhor = imfilter(lab,kernelhor);

filtered = (filteredver.^2+filteredhor.^2).^0.5;

%LAB to RGB conversion on Filtered Image
filteredtoRGB = lab2rgb(filtered);

%Bilateral Masking on LAB image
smoothedLAB = imbilatfilt(lab);

%LAB to RGB conversion on Bilateral Filtered Image
smoothedLAB = lab2rgb(smoothedLAB);

filteredtoRGB = im2uint16(filteredtoRGB);
smoothedLAB = im2uint16(smoothedLAB);

%Cartoning image
final = bitor(filteredtoRGB,smoothedLAB);

axes(handles.axes2);
imshow(final);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global aaaaa
I = (aaaaa);

%% Bilateral filter
bi = bilateralfiltering(I, 5);

%% Quantization
quan = quantize_img(bi);
quan = blur_img(quan, 1);

%% Differnce of Gaussian
e = DiffGaussian(bi, 5, 0.5);
e = rgb2gray(e);
e = imbinarize(e);

se = strel('line', 1,0);
e = imdilate(e, se);
e = imcomplement(e);

%% Combine
fin = combining(e, quan, 140);
fin = blur_img(fin, 2);
%fin = enhancecolor(fin,200);
fin = hsv2rgb(rgb2hsv(fin) .* cat(3, 1, 1.1, 1)); 

%fin = lab2rgb(fin);
%fin = warp(fin);
axes(handles.axes8);
imshow(fin);
