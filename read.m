function varargout = read(varargin)
% READ MATLAB code for read.fig
%      READ, by itself, creates a new READ or raises the existing
%      singleton*.
%
%      H = READ returns the handle to a new READ or the handle to
%      the existing singleton*.
%
%      READ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READ.M with the given input arguments.
%
%      READ('Property','Value',...) creates a new READ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before read_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to read_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help read

% Last Modified by GUIDE v2.5 20-Mar-2019 14:02:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @read_OpeningFcn, ...
                   'gui_OutputFcn',  @read_OutputFcn, ...
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


% --- Executes just before read is made visible.
function read_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to read (see VARARGIN)

% Choose default command line output for read
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes read wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = read_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in edit2.
function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename filepath fileindex]=uigetfile({'*.txt','文本文件(*.txt)';...
    '*.xls','Excel文件(*.xls)';'*.*','所有文件(*.*)'},'选择文件');  %选择文件
if fileindex~=0   %如果没有点击取消
    l = length(filename);   %filename包含后缀名
    if l <= 4
        errordlg('错误文件','文件打开错误');  %错误对话框
        return;
    end
    test=filename(1,l-3:l);   %文件名，截取后缀名
    switch test
        
        case '.xls'   %如果是表格文件
            str = [filepath filename];   %拼接绝对路径
            set(handles.edit2,'String',str);  %
            h = waitbar(0,'正在读取文件....');   %进度条(打开文件比较慢)
            [num txt] = xlsread(str);  %根据绝对路径，打开xls文件
            waitbar(1,h,'完成');
            delete(h);    
            num
            txt
            time1 = num(:,1)
            parameters1 = num(:,2)
            %set(handles.edit1,'String',time);         %设置listbox1的显示内容
            %set(handles.edit1,'String',parameters);   %设置listbox2的显示内容
            handles.time1 = time1     %将time放入到全局变量中
            handles.parameters1 = parameters1
            guidata(hObject, handles);   %更新gui数据
            
        case '.txt'
            str = [filepath filename];        %路径
            set(handles.edit2,'String',str);  
            h=waitbar(0,'正在读取文件....');   %进度条
            [time2,parameters2] = textread(str, '%s%s','headerlines', 0);  
            waitbar(1,h,'完成');
            delete(h);    
%            time
%            parameters
%            size(time)
%            size(parameters)

            %set(handles.edit1,'String',time);         %设置listbox1的显示内容
            %set(handles.edit1,'String',parameters);   %设置listbox2的显示内容
            
            handles.time2 = time2                  %将time放入到全局变量中
            handles.parameters2 = parameters2
            guidata(hObject, handles);             %更新gui数据
%         otherwise
%             errordlg('文件类型错误','文件错误');  
%             return;
    end      
end



% --- Executes on button press in interpolate1.
function interpolate1_Callback(hObject, eventdata, handles)
% hObject    handle to interpolate1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%xls文件插值
data_x1 = double(handles.time1)
data_y1 = double(handles.parameters1)
data_x1(end)                                 %取向量最后一个数
new_x1 = 0:0.001:data_x1(end);                   %此时的xi为新的时间点
%样条插值求值函数，以矩阵方式计算多项式，对流量文件插值
new_y1 = interp1(data_x1,data_y1,new_x1,'poly');
% axis([0,1,-50,200])
plot(new_x1,new_y1)


% --- Executes on button press in interpolate2.
function interpolate2_Callback(hObject, eventdata, handles)
% hObject    handle to interpolate2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%txt文件插值
data_x2 = str2double(handles.time2)
data_y2 = str2double(handles.parameters2)
data_x2(end)                                 %取向量最后一个数
new_x2 = 0:0.001:data_x2(end);                   %此时的xi为新的时间点
%样条插值求值函数，以矩阵方式计算多项式，对流量文件插值
new_y2 = interp1(data_x2,data_y2,new_x2,'poly');
% axis([0,1,-50,200])
plot(new_x2,new_y2)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 退出按钮--------
% clc;
% clear all;
close(gcf);
