% Example of mock confocal data generation
%   We first generate a baseball seam curve
%   We then make it confocal
%   We then segment it


%% CONFOCAL GN Parameters
% Properties of the microscope
<<<<<<< HEAD
conf.psf=[13 13 22];
conf.pix=[8 8 32];
=======
%conf.psf=[8 8 32];
conf.psf=[8 8 32];
conf.pix=[6 6 24];


%% PARAMETER for ground truth generation
% Properties of the fluorophores
%   gaussian fluorescence is assumed for all points in the original signal
%   This is VERY tough to estimate theoretically as it depends on the
%   number of fluorophores, exposure time, etc.
fluo=[5 5];
% Background fluorescence
bkgd=[0 0 0];
% Degree of coiling of the base ball seam curve
b=0.00;
% Orientation of the BBseam curve
angs=[pi/12 -pi/12 0];
% Radius of the sphere containing BB seam curve
R=60;
% Resolution 
dt=0.001;
% Size of the ground truth in discretized units
Npts=[300 300 300];
%% Generating a set of points ; here, a BBseam curve
RR=generate_bbseam(Npts,b,R,dt,angs);
%% Generating an image from these points
% Image includes fluorophore stochasticity and background fluorescence
[img,pts]=generate_pts_img(Npts,RR,fluo,bkgd);
>>>>>>> 19388cf65ce9adf535eb387eb118dc62b993c194

%% Ground truth generation
% Img is the hi-res 3D image containing the ground truth
[img,~]=make_ground_truth();

%% Reading Noise and Signal parameters from image
if 1
    % sample image
    sample='sample_image.tiff';
    %% Generating the stack from the image
    % Includes pixel noise
    [stacks,offset,achieved_sig,achieved_noise,im,mean_sig,noise]=confocal_generator(img,conf,sample);
else
%% Using noise and singal values 
    % pixel noise from camera
    noise=[556 1.0371e+04 1.0926e+06]';
    % Estimated mean pix value in signal
    mean_sig=1.0022e+03;
    [stacks,offset,achieved_sig,achieved_noise,im]=stack_generator(img,conf,noise,mean_sig);
end



%% Graphical output : Image segmentation & plotting to compare simulated data to original
if 1
    pix=conf.pix;
    % We then convert from stack to pixel coordinatees Pts and intensities W
    [ Pts,W ] = convertpoints( im , conf.pix );
    % Conveerting ground truth image to points
    [ ~,~,img2] = get_img_params(img);
    pts = convertpoints( img2 );
    % Plotting
    Pts(1:3,:)=Pts(1:3,:)-offset(1:3)'*ones(1,size(Pts,2));
    figure
    hold all
    scatter3(pts(1,:)/pix(1),pts(2,:)/pix(1),pts(3,:)/pix(1),'k.')
<<<<<<< HEAD
    scatter3(Pts(1,:)/pix(1),Pts(2,:)/pix(1),Pts(3,:)/pix(1),'b')
    axis equal
end
=======
end
>>>>>>> 19388cf65ce9adf535eb387eb118dc62b993c194