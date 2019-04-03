function varargout = simiulation(varargin)
% SIMIULATION MATLAB code for simiulation.fig
%      SIMIULATION, by itself, creates a new SIMIULATION or raises the existing
%      singleton*.
%
%      H = SIMIULATION returns the handle to a new SIMIULATION or the handle to
%      the existing singleton*.
%
%      SIMIULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMIULATION.M with the given input arguments.
%
%      SIMIULATION('Property','Value',...) creates a new SIMIULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simiulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simiulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simiulation

% Last Modified by GUIDE v2.5 21-Aug-2018 11:10:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simiulation_OpeningFcn, ...
                   'gui_OutputFcn',  @simiulation_OutputFcn, ...
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


% --- Executes just before simiulation is made visible.
function simiulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simiulation (see VARARGIN)

% Choose default command line output for simiulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simiulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simiulation_OutputFcn(hObject, eventdata, handles) 
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

%选择图片路径
 [filename,pathname] = ...
     uigetfile({'*.png';'*.bmp';'*.gif'},'选择图片');
 %合成路径以及文件名称
 str=[pathname filename];
 %读取图片
 im=imread(str);
 %使用第一个axes
 axes(handles.axes1);
 %显示图片
 imshow(im);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)
