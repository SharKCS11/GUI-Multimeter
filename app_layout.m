function varargout = app_layout(varargin)
%APP_LAYOUT MATLAB code file for app_layout.fig
%      APP_LAYOUT, by itself, creates a new APP_LAYOUT or raises the existing
%      singleton*.
%
%      H = APP_LAYOUT returns the handle to a new APP_LAYOUT or the handle to
%      the existing singleton*.
%
%      APP_LAYOUT('Property','Value',...) creates a new APP_LAYOUT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to app_layout_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      APP_LAYOUT('CALLBACK') and APP_LAYOUT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in APP_LAYOUT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help app_layout

% Last Modified by GUIDE v2.5 06-Aug-2016 14:50:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @app_layout_OpeningFcn, ...
                   'gui_OutputFcn',  @app_layout_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before app_layout is made visible.
function app_layout_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

handles.call_break=5;
% Choose default command line output for app_layout
handles.output = hObject;
set(handles.text4,'String','Press Measure to Start');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes app_layout wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = app_layout_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in stop_btn.
function stop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to stop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.call_break=1;
guidata(hObject,handles);
set(handles.text4,'String','Press Measure to Start');
drawnow;


% --- Executes on button press in msr_btn.
function msr_btn_Callback(hObject, eventdata, handles)
% hObject    handle to msr_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.call_break=0;
guidata(hObject,handles);
clear ard;
ard=arduino('COM3','Mega2560');
while(true)
    redval = readVoltage(ard,'A1');
    volt_str=sprintf('%.2f V',redval*2);
    set(handles.text4,'String',volt_str);
    pause(1);
    handles=guidata(hObject);
    if(handles.call_break==1)
        break;
    end
end
