% Create a simple Matlab figure (visible, but outside monitor area)
t = 0 : 0.01 : 10;
hFig = figure('Name','Plot example', 'ToolBar','none', 'MenuBar','none','units','normalized','outerposition',[0 0 1 1]);

%-------------Insert your code below:
starttext = text(0.45,0.5,'Get READY','color','k','fontsize',30);


%-------------Up to here
hButton = uicontrol('String','Close', 'Position',[307,0,45,16]);
 
% Ensure that everything is rendered, otherwise the following will fail
drawnow;
 
% Get the underlying Java JFrame reference handle
mjf = get(handle(hFig), 'JavaFrame');
jWindow = mjf.fHG2Client.getWindow;  % or: mjf.getAxisComponent.getTopLevelAncestor
 
% Get the content pane's handle
mjc = jWindow.getContentPane;
mjr = jWindow.getRootPane;  % used for the offset below
 
% Create a new pure-Java undecorated JFrame
figTitle = jWindow.getTitle;
jFrame = javaObjectEDT(javax.swing.JFrame(figTitle));
jFrame.setUndecorated(true);
 
% Move the JFrame's on-screen location just on top of the original
jFrame.setLocation(mjc.getLocationOnScreen);
 
% Set the JFrame's size to the Matlab figure's content size
%jFrame.setSize(mjc.getSize);  % slightly incorrect by root-pane's offset
jFrame.setSize(mjc.getWidth+mjr.getX, mjc.getHeight+mjr.getY);
 
% Reparent (move) the contents from the Matlab JFrame to the new JFrame
jFrame.setContentPane(mjc);
 
% Make the new JFrame visible
jFrame.setVisible(true);
 
% Hide the Matlab figure by moving it off-screen
pos = get(hFig,'Position');
set(hFig, 'Position',[-1000,-1000,pos(3:4)]);
drawnow;