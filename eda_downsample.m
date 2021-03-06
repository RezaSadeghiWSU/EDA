function [eda,newfs] = eda_downsample(eda, fs, reqfs)
% EDA_DOWNSAMPLE EDA downsample
%   [edaout newfs] = EDA_DOWNSAMPLE(edain, fs, reqfs)
%
% Required input arguments:
%    eda     - 1-by-n vector of EDA samples
%    fs      - old samplig frequency (Hz)
%    reqfs   - requested sampling frequency (Hz)
%
% Output arguments:
%    eda     - downsampled EDA data
%    newfs   - new sampling rate (Hz)
%
% Description: 
%    Use only if EDA has been acquired with very high sampling rate 
%    (e.g. inside the MR scanner). Make sure that the Shannon-Nyquist 
%    sampling theorem criterion is satisfied. Use only after low-pass 
%    filtering EDA (see eda_filt.m).
% _________________________________________________________________________

% Last modified 23-11-2010 Mateus Joffily

% Copyright (C) 2002, 2007, 2010 Mateus Joffily, mateusjoffily@gmail.com.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

if nargin < 3 || isempty(reqfs)
    prompt   = {'Enter new sampling rate (Hz)'};
    def      = {sprintf('%.02f', fs)};
    dlgTitle = 'Downsample EDA';
    lineNo   = 1;
    answer   = inputdlg(prompt,dlgTitle,lineNo,def);

    if ~isempty(answer) && ~isempty(answer{1})
        reqfs = str2double(answer{1});
        
    else
        % Goodbye message
        disp([mfilename ': done.']);
        
        return
    end    
end

% Calculate downsampling factor
M = ceil( fs / reqfs );

if M > 1
    eda = eda(:, 1:M:end);
    newfs  = fs / M;
end

% Goodbye message
disp([mfilename ': done.']);