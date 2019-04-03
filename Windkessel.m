function varargout = Windkessel(varargin)
% WINDKESSEL MATLAB code for Windkessel.fig
%      WINDKESSEL, by itself, creates a new WINDKESSEL or raises the existing
%      singleton*.
%
%      H = WINDKESSEL returns the handle to a new WINDKESSEL or the handle to
%      the existing singleton*.
%
%      WINDKESSEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDKESSEL.M with the given input arguments.
%
%      WINDKESSEL('Property','Value',...) creates a new WINDKESSEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Windkessel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Windkessel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Windkessel

% Last Modified by GUIDE v2.5 10-Jul-2018 19:20:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Windkessel_OpeningFcn, ...
                   'gui_OutputFcn',  @Windkessel_OutputFcn, ...
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


% --- Executes just before Windkessel is made visible.
function Windkessel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Windkessel (see VARARGIN)
backgroundImage = imread('3E.png');
%select the axes
axes(handles.axes1);
%place image onto the axes
image(backgroundImage);
%remove the axis tick marks
axis off

% Choose default command line output for Windkessel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Windkessel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Windkessel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function pp = inlet(t)          %定义样条插值方法插值得到任意点的函数值
    global t2;
    global v2;
    pp=interp1(t2,v2,t,'spline');
    
function f = p2f( x,y,R,r,C,h )         %定义压力到流量的求解函数
    f=-(R+r)/(C*R*r)*y+1/(R*r*C)*inlet(x)+(inlet(x+h)-inlet(x))/(r*h);
    
function g = f2p( x,y,R,r,C,h )         %定义流量到压力的求解函数
   g=-1/(C*R)*y+(R+r)/(R*C)*inlet(x)+r*(inlet(x+h)-inlet(x))/h;
   
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global U;
global x;
R_text = get(handles.edit1,'String');
R = str2num (R_text);
C_text = get(handles.edit2,'String');
C = str2num (C_text);
r_text = get(handles.edit3,'String');
r = str2num (r_text);
T_text = get(handles.edit5,'String');
T = str2num (T_text);
h_text = get(handles.edit6,'String');
h = str2num (h_text);
IC_text=get(handles.edit7,'String');
IC=str2num(IC_text);
k=T/h;
x=zeros(1,k+1);
x(1+k)=T;
I=zeros(1,k+1);
U=zeros(1,1+k);  
I(1)=IC;                    %定义流量初值
for n=2:k+1                 %四阶龙格库塔方法
    x(n-1)=(n-2)*h;
    K1=p2f(x(n-1),I(n-1),R,r,C,h);
    K2=p2f(x(n-1)+h/2,I(n-1)+h*K1/2,R,r,C,h);
    K3=p2f(x(n-1)+h/2,I(n-1)+h*K2/2,R,r,C,h);
    K4=p2f(x(n-1)+h,I(n-1)+h*K3,R,r,C,h);
    I(n)=I(n-1)+h*(K1+2*K2+2*K3+K4)/6;
end
axes(handles.axes2);
plot(x,I,'-r');
guidata(hObject, handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global U;
global x;
R_text = get(handles.edit1,'String');
R = str2num (R_text);
C_text = get(handles.edit2,'String');
C = str2num (C_text);
r_text = get(handles.edit3,'String');
r = str2num (r_text);
T_text = get(handles.edit5,'String');
T = str2num (T_text);
h_text = get(handles.edit6,'String');
h = str2num (h_text);
IC_text=get(handles.edit7,'String');
IC=str2num(IC_text);
k=T/h;
x=zeros(1,k+1);
x(1+k)=T;
I=zeros(1,k+1);
U=zeros(1,1+k);         
U(1)=IC;                                                %定义压力初值
for n=2:(1+k)                                           %四阶龙格库塔方法
    x(n-1)=(n-2)*h;
    K1=f2p(x(n-1),U(n-1),R,r,C,h);
    K2=f2p(x(n-1)+h/2,U(n-1)+h*K1/2,R,r,C,h);
    K3=f2p(x(n-1)+h/2,U(n-1)+h*K2/2,R,r,C,h);
    K4=f2p(x(n-1)+h,U(n-1)+h*K3,R,r,C,h);
    U(n)=U(n-1)+h*(K1+2*K2+2*K3+K4)/6;
end
axes(handles.axes2);
plot(x,U,'-r');
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M;
[filename,pathname] = uigetfile({'*.txt','Txt Files(*.txt)';'.xls',...        
    'Excel Files(.xls)';'*.*','All Files(*.*)'},'Choose a File');
L = length(filename);
str = [pathname,filename];

test0 = filename(1,L-3:L);                %读取外部时间序列文件
switch test0
    case '.txt'
        M = textread(str);

    case '.xls'
        M = xlsread(str);

end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global U;
global I;
global x;
[filename,pathname]=uiputfile({'*.txt';'*.xls'},'Save as');
L=length(filename);
str=[pathname,filename];
Result=U+I;
ll=length(Result);
for i=1:ll
    result(i,1)=x(i);
end
for i=1:ll
    result(i,2)=Result(i);
end
test0=filename(1,L-3:L);
[row,col]=size(result);                 %写出结果时间序列文件
switch test0
    case '.txt'
        fid = fopen(str,'w');  
        for i=1:row
            for j=1:col
                fprintf(fid,'%f\t',result(i,j));
            end
            fprintf(fid,'\r\n');
        end
        fclose(fid);

    case '.xls'
        xlswrite(str,result);    

end



function edit1_Callback(hObject, eventdata, handles)    %读取R
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)    %读取C
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)    %读取r
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)      %样条拟合外部时间序列
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M;
global t2;
global v2;

T_text = get(handles.edit5,'String');
T = str2num(T_text);
h_text = get(handles.edit6,'String');
h = str2num(h_text);
s_text = get(handles.edit4,'String');
s = str2num(s_text);

[row, col] = size(M);
t = M(:,1);
v = M(:,2);
ss = 2-length(s_text);
m = row-1;

%t1 = zeros(row,1);
% for i = 1:row
%     t1(i,1)=round(t(i),ss);matlab可以用round将double格式转化为整型
% end
%可以用下面一行代替
t1 = roundn(t, ss);

T0 = t1(row,1) - t1(1,1)
n = round(T0/s);%转化为整型
k_max = fix(T/T0)+1;
for k=1:k_max
    for i=1:m+1
        t2((k-1)*m+i,1) = t1(i,1) + (k-1)*t1(row,1);
        v2((k-1)*m+i,1) = v(i);
    end
end

% x1 = zeros(n+1,1);之前出现的错误为错误使用zeros，size必须为整数，...
%n需要是整数，在第345行加上round,转化为整型
% x1(1,1) = t1(1,1);
% for i = 1:n+1
%     x1(i,1) = x1(1,1)+(i-1)*s;
% end
%可用下面的矩阵化运算代替
x1 = t1(1,1) + (0:n)' * s; 

for k=1:k_max
    for i=1:n+1
        x2((k-1)*n+i)=x1(i,1)+(k-1)*T0;
    end
end

% 确保t2升序，并与v2保持对应关系
temp = sortrows([t2, v2], 1);
t2 = temp(:, 1);
v2 = temp(:, 2);

y2 = interp1(t2, v2, x2,'poly');
figure
% plot(x1,'ob');
% hold on
% plot(t1,v,'-g');
% hold on
plot(x2,y2,'-r');
guidata(hObject, handles);


function edit4_Callback(hObject, eventdata, handles)        %读取拟合间隔
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)    %读取总求解时间
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)    %读取时间步长
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
