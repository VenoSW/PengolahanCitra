function varargout = GUI_VENO(varargin)
% GUI_VENO MATLAB code for GUI_VENO.fig
%      GUI_VENO, by itself, creates a new GUI_VENO or raises the existing
%      singleton*.
%
%      H = GUI_VENO returns the handle to a new GUI_VENO or the handle to
%      the existing singleton*.
%
%      GUI_VENO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_VENO.M with the given input arguments.
%
%      GUI_VENO('Property','Value',...) creates a new GUI_VENO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_VENO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_VENO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_VENO

% Last Modified by GUIDE v2.5 29-Apr-2021 13:01:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_VENO_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_VENO_OutputFcn, ...
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


% --- Executes just before GUI_VENO is made visible.
function GUI_VENO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_VENO (see VARARGIN)

% Choose default command line output for GUI_VENO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_VENO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_VENO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

reqToolboxes = {'Computer Vision System Toolbox', 'Image Processing Toolbox'};
info = ver;
s=size(info);
 
flg = zeros(size(reqToolboxes));
reqSize = size(reqToolboxes,2);
 
for i=1:s(2)
    for j=1:reqSize
        if( strcmpi(info(1,i).Name,reqToolboxes{1,j}) )
            flg(1,j)=1;
        end
    end
end
ret = prod(flg);
 
if ~ret
    error('detectFaceParts requires: Computer Vision System Toolbox and Image Processing Toolbox. Please install these toolboxes.');
end

% --------------------------------------------------------------------
function RGB_Channel_Callback(hObject, eventdata, handles)
% hObject    handle to RGB_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_home,'visible','off');
set(handles.panel_rgb,'visible','on');
set(handles.panel_perbaikancitra,'visible','off');
set(handles.panel_deteksiwajah,'visible','off');

% --------------------------------------------------------------------
function Perbaikan_Citra_Callback(hObject, eventdata, handles)
% hObject    handle to Perbaikan_Citra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_home,'visible','off');
set(handles.panel_rgb,'visible','off');
set(handles.panel_perbaikancitra,'visible','on');
set(handles.panel_deteksiwajah,'visible','off');

% --------------------------------------------------------------------
function Deteksi_Wajah_Callback(hObject, eventdata, handles)
% hObject    handle to Deteksi_Wajah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_home,'visible','off');
set(handles.panel_rgb,'visible','off');
set(handles.panel_perbaikancitra,'visible','off');
set(handles.panel_deteksiwajah,'visible','on');

% --------------------------------------------------------------------
function Keluar_Callback(hObject, eventdata, handles)
% hObject    handle to Keluar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pilihan = questdlg('Apakah anda ingin menutup program?', ...
 'Menutup Program', ...
 'Ya','Tidak','Tidak');
% Handle response
switch pilihan
    case 'Ya'
        close(GUI_VENO);
    case 'Tidak'
        return;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.*');
% untuk untuk menyeleksi file gambar khusus RGB
if ~isequal(filename,0)
Img = imread(fullfile(pathname,filename));
[~,~,m] = size(Img);
if m == 3
axes(handles.axes1)
imshow(Img)
handles.Img = Img;
title('RGB Image')
guidata(hObject, handles)
else
msgbox('Citra masukan harus citra RGB')
end
else
return
end
% untuk mengaktifkan radiobutton
set(handles.radiobutton1,'Enable','on')
set(handles.radiobutton2,'Enable','on')
set(handles.radiobutton3,'Enable','on')
set(handles.radiobutton4,'Enable','on')
axes(handles.axes2)
cla('reset')

set(gca,'XTick',[])
set(gca,'YTick',[])

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

set(handles.radiobutton1,'Value',1)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
% Menampilkan gambar RGB yg sudah dipilih
Img = handles.Img;
axes(handles.axes1)
imshow(Img)
title('RGB Image')
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Menampilkan histogram RGB
axes(handles.axes2)
cla('reset')
h = histogram(R(:));
h.FaceColor = [1 0 0];
xlim([0 255])
grid on
hold on
h = histogram(G(:));
h.FaceColor = [0 1 0];
xlim([0 255])

h = histogram(B(:));
h.FaceColor = [0 0 1];
xlim([0 255])
hold off
title('Histogram')

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',1)
set(handles.radiobutton4,'Value',0)
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Untuk merubah gambar RGB menjadi layer Green
Green_Channel = cat(3,R*0,G,B*0);
axes(handles.axes1)
cla('reset')
imshow(Green_Channel)
title('Green Channel')
% Menampilkan Histogram layer Green
axes(handles.axes2)
cla('reset')
h = histogram(G(:));
h.FaceColor = [0 1 0];
xlim([0 255])
grid on
title('Histogram')

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',0)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',1)
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Untuk merubah gambar RGB menjadi layer Green
Blue_Channel = cat(3,R*0,G*0,B);
axes(handles.axes1)
cla('reset')
imshow(Blue_Channel)
title('Blue Channel')
% Menampilkan Histogram layer Blue
axes(handles.axes2)
cla('reset')
h = histogram(B(:));
h.FaceColor = [0 0 1];
xlim([0 255])
grid on
title('Histogram')


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

set(handles.radiobutton1,'Value',0)
set(handles.radiobutton2,'Value',1)
set(handles.radiobutton3,'Value',0)
set(handles.radiobutton4,'Value',0)
Img = handles.Img;
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
% Untuk merubah gambar RGB menjadi layer Red
Red_Channel = cat(3,R,G*0,B*0);
axes(handles.axes1)
cla('reset')
imshow(Red_Channel)
title('Red Channel')
% Menampilkan Histogram layer Red
axes(handles.axes2)
cla('reset')
h = histogram(R(:));
h.FaceColor = [1 0 0];
xlim([0 255])
grid on
title('Histogram')


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile({'*.*'});
 
if ~isequal(filename,0)
    Info = imfinfo(fullfile(pathname,filename));
    if Info.BitDepth == 1
        msgbox('Citra masukan harus citra RGB atau Grayscale');
        return
    elseif Info.BitDepth == 8
        img = imread(fullfile(pathname,filename));
        axes(handles.axes1)
        cla('reset')
        imshow(img)
    else
        img = rgb2gray(imread(fullfile(pathname,filename)));
        axes(handles.axes3)
        cla('reset')
        imshow(img)
        title('Original Image')
    end
else
    return
end
 
handles.img = img;
guidata(hObject,handles);

set(handles.radiobutton5,'Enable','on')
set(handles.radiobutton6,'Enable','on')
set(handles.radiobutton7,'Enable','on')
axes(handles.axes4)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes5)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes6)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
set(handles.radiobutton5,'Value',1)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',0)
 
img = handles.img;
I_adjust = imadjust(img);
 
axes(handles.axes3)
cla('reset')
imshow(img)
colormap(handles.axes3,'gray')
title('Sebelum Peningkatan Kontras')
 
axes(handles.axes4)
h = histogram(img(:));
h.FaceColor = [0.5 0.5 0.5];
xlim([0 255])
grid on
title('Histogram')
 
axes(handles.axes5)
cla('reset')
imshow(I_adjust)
colormap(handles.axes5,'gray')
title('Sesudah Peningkatan Kontras')
 
axes(handles.axes6)
h = histogram(I_adjust(:));
h.FaceColor = [0.5 0.5 0.5];
xlim([0 255])
grid on
title('Histogram')

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',1)
set(handles.radiobutton7,'Value',0)
 
img = handles.img;
I_adjust = imadjust(img,[0 1],[0.2 0.8]);
 
axes(handles.axes1)
cla('reset')
imshow(img)
colormap(handles.axes3,'gray')
title('Sebelum Penurunan Kontras')
 
axes(handles.axes4)
h = histogram(img(:));
h.FaceColor = [0.5 0.5 0.5];
xlim([0 255])
grid on
title('Histogram')
 
axes(handles.axes5)
cla('reset')
imshow(I_adjust)
colormap(handles.axes5,'gray')
title('Sesudah Penurunan Konras')
 
axes(handles.axes6)
h = histogram(I_adjust(:));
h.FaceColor = [0.5 0.5 0.5];
xlim([0 255])
grid on
title('Histogram')

% --------------------------------------------------------------------
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panel_home,'visible','on');
set(handles.panel_rgb,'visible','off');
set(handles.panel_perbaikancitra,'visible','off');
set(handles.panel_deteksiwajah,'visible','off');

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
set(handles.radiobutton5,'Value',0)
set(handles.radiobutton6,'Value',0)
set(handles.radiobutton7,'Value',1)
 
img = handles.img;
I_adjust = histeq(img);
 
axes(handles.axes3)
cla('reset')
imshow(img)
colormap(handles.axes3,'gray')
title('Sebelum Perataan Kontras')
 
axes(handles.axes4)
h = histogram(img(:));
h.FaceColor = [0.5 0.5 0.5];
xlim([0 255])
grid on
title('Histogram')
 
axes(handles.axes5)
cla('reset')
imshow(I_adjust)
colormap(handles.axes5,'gray')
title('Sesudah Perataan Kontras')
 
axes(handles.axes6)
h = histogram(I_adjust(:));
h.FaceColor = [0.5 0.5 0.5];
xlim([0 255])
grid on
title('Histogram')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.*');
if ~isequal(filename,0)
    handles.data1 = imread(fullfile(pathname,filename));
    guidata(hObject,handles);
    axes(handles.axes7)
    cla reset
    imshow(handles.data1);
else
    return
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
X = handles.data1;
thresholdFace = 1;
thresholdParts = 1;
stdsize = 176;
 
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];
 
detector.stdsize = stdsize;
detector.detector = cell(5,1);
for k=1:4
    minSize = int32([stdsize/5 stdsize/5]);
    minSize = [max(minSize(1),mins(k,1)), max(minSize(2),mins(k,2))];
    detector.detector{k} = vision.CascadeObjectDetector(char(nameDetector(k)), 'MergeThreshold', thresholdParts, 'MinSize', minSize);
end
 
detector.detector{5} = vision.CascadeObjectDetector('FrontalFaceCART', 'MergeThreshold', thresholdFace);
 
%%%%%%%%%%%%%%%%%%%%%%% detect face %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detect faces
bbox = step(detector.detector{5}, X);
 
bbsize = size(bbox);
partsNum = zeros(size(bbox,1),1);
 
%%%%%%%%%%%%%%%%%%%%%%% detect parts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stdsize = detector.stdsize;
 
for k=1:4
    if( k == 1 )
        region = [1,int32(stdsize*2/3); 1, int32(stdsize*2/3)];
    elseif( k == 2 )
        region = [int32(stdsize/3),stdsize; 1, int32(stdsize*2/3)];
    elseif( k == 3 )
        region = [1,stdsize; int32(stdsize/3), stdsize];
    elseif( k == 4 )
        region = [int32(stdsize/5),int32(stdsize*4/5); int32(stdsize/3),stdsize];
    else
        region = [1,stdsize;1,stdsize];
    end
     
    bb = zeros(bbsize);
    for i=1:size(bbox,1)
        XX = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
        XX = imresize(XX,[stdsize, stdsize]);
        XX = XX(region(2,1):region(2,2),region(1,1):region(1,2),:);
         
        b = step(detector.detector{k},XX);
         
        if( size(b,1) > 0 )
            partsNum(i) = partsNum(i) + 1;
             
            if( k == 1 )
                b = sortrows(b,1);
            elseif( k == 2 )
                b = flipud(sortrows(b,1));
            elseif( k == 3 )
                b = flipud(sortrows(b,2));
            elseif( k == 4 )
                b = flipud(sortrows(b,3));
            end
             
            ratio = double(bbox(i,3)) / double(stdsize);
            b(1,1) = int32( ( b(1,1)-1 + region(1,1)-1 ) * ratio + 0.5 ) + bbox(i,1);
            b(1,2) = int32( ( b(1,2)-1 + region(2,1)-1 ) * ratio + 0.5 ) + bbox(i,2);
            b(1,3) = int32( b(1,3) * ratio + 0.5 );
            b(1,4) = int32( b(1,4) * ratio + 0.5 );
             
            bb(i,:) = b(1,:);
        end
    end
    bbox = [bbox,bb];
end
 
 
%%%%%%%%%%%%%%%%%%%%%%% draw faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bbox = [bbox,partsNum];
bbox(partsNum<=2,:)=[];
 
face =  bbox(:,1: 4);
axes(handles.axes8)
cla reset
imshow(X);
hold on
 
[m, ~] = size(face);
for j = 1:m
    rectangle('Position',[face(j,1),face(j,2),face(j,3),face(j,4)],'EdgeColor','y','LineWidth',2);
end
hold off
toc
% for k = 1:m
%     imcrop(X,[face(k,1),face(k,2),face(k,3),face(k,4)]);
% end
