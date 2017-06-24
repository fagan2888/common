






  


  
  
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
      <meta http-equiv="X-UA-Compatible" content="IE=8"/>
      
      <!-- START OF GLOBAL NAV -->
  <link rel="stylesheet" href="/matlabcentral/css/sitewide.css" type="text/css">
  <link rel="stylesheet" href="/matlabcentral/css/mlc.css" type="text/css">
  <!--[if lt IE 7]>
  <link href="/matlabcentral/css/ie6down.css" type="text/css" rel="stylesheet">
  <![endif]-->

      
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="keywords" content="file exchange, matlab answers, newsgroup access, link exchange, matlab blog, matlab central, simulink blog, matlab community, matlab and simulink community">
<meta name="description" content="File exchange, MATLAB Answers, newsgroup access, Links, and Blogs for the MATLAB &amp; Simulink user community">
<link rel="stylesheet" type="text/css" media="print" href="/matlabcentral/css/print.css" />
<title> File Exchange - MATLAB Central</title>
<script src="/matlabcentral/fileexchange/javascripts/jquery-1.9.1.min.js?1396618518" type="text/javascript"></script>
<script src="/matlabcentral/fileexchange/javascripts/jquery-ui-1.10.1.min.js?1396618518" type="text/javascript"></script>
<script src="/matlabcentral/fileexchange/javascripts/jquery_ujs.js?1396618518" type="text/javascript"></script>
<script src="/matlabcentral/fileexchange/javascripts/application.js?1396618518" type="text/javascript"></script>
<link href="/matlabcentral/fileexchange/stylesheets/application.css?1396618518" media="screen" rel="stylesheet" type="text/css" />
<link href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/jacobianest.m" rel="canonical" />

<link rel="search" type="application/opensearchdescription+xml" title="Search File Exchange" href="/matlabcentral/fileexchange/search.xml" />


  </head>
    <body>
      <div id="header">
  <div class="wrapper">
  <!--put nothing in left div - only 11px wide shadow --> 
    <div class="main">
        	<div id="logo"><a href="/matlabcentral/?s_tid=gn_mlc_logo" title="MATLAB Central Home"><img src="/matlabcentral/images/mlclogo-whitebgd.gif" alt="MATLAB Central" /></a></div>
      
        <div id="headertools">
        

<script language="JavaScript1.3" type="text/javascript">

function submitForm(query){

	choice = document.forms['searchForm'].elements['search_submit'].value;
	
	if (choice == "entire1" || choice == "contest" || choice == "matlabcentral" || choice == "blogs"){
	
	   var newElem = document.createElement("input");
	   newElem.type = "hidden";
	   newElem.name = "q";
	   newElem.value = query.value;
	   document.forms['searchForm'].appendChild(newElem);
	      
	   submit_action = '/searchresults/';
	}
	
	switch(choice){
	   case "matlabcentral":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "matlabcentral";
	      document.forms['searchForm'].appendChild(newElem);
	
	      selected_index = 0;
	      break
	   case "fileexchange":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/fileexchange/";
	      selected_index = 1;
	      break
	   case "answers":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/answers/";
	      selected_index = 2;
	      break
	   case "cssm":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "search_string";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
		  submit_action = "/matlabcentral/newsreader/search_results";
	      selected_index = 3;
	      break
	   case "linkexchange":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/linkexchange/";
	      selected_index = 4;
	      break
	   case "blogs":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "blogs";
	      document.forms['searchForm'].appendChild(newElem);
	
	      selected_index = 5;
	      break
	   case "trendy":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "search";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/trendy";
	      selected_index = 6;
	      break
	   case "cody":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "term";
	      newElem.value = query.value;
	      newElem.classname = "formelem";
	      document.forms['searchForm'].appendChild(newElem);
	
	      submit_action = "/matlabcentral/cody/";
	      selected_index = 7;
	      break
	   case "contest":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "contest";
	      document.forms['searchForm'].appendChild(newElem);
	
	      selected_index = 8;
	      break
	   case "entire1":
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "entiresite";
	      document.forms['searchForm'].appendChild(newElem);
	      
	      selected_index = 9;
	      break
	   default:
	      var newElem = document.createElement("input");
	      newElem.type = "hidden";
	      newElem.name = "c[]";
	      newElem.value = "entiresite";
	      document.forms['searchForm'].appendChild(newElem);
	   
	      selected_index = 9;
	      break
	}

	document.forms['searchForm'].elements['search_submit'].selectedIndex = selected_index;
	document.forms['searchForm'].elements['query'].value = query.value;
	document.forms['searchForm'].action = submit_action;
}

</SCRIPT>


  <form name="searchForm" method="GET" action="" style="margin:0px; margin-top:5px; font-size:90%" onSubmit="submitForm(query)">
          <label for="search">Search: </label>
        <select name="search_submit" style="font-size:9px ">
         	 <option value = "matlabcentral">MATLAB Central</option>
          	<option value = "fileexchange" selected>&nbsp;&nbsp;&nbsp;File Exchange</option>
          	<option value = "answers">&nbsp;&nbsp;&nbsp;Answers</option>
            <option value = "cssm">&nbsp;&nbsp;&nbsp;Newsgroup</option>
          	<option value = "linkexchange">&nbsp;&nbsp;&nbsp;Link Exchange</option>
          	<option value = "blogs">&nbsp;&nbsp;&nbsp;Blogs</option>
          	<option value = "trendy">&nbsp;&nbsp;&nbsp;Trendy</option>
          	<option value = "cody">&nbsp;&nbsp;&nbsp;Cody</option>
          	<option value = "contest">&nbsp;&nbsp;&nbsp;Contest</option>
          <option value = "entire1">MathWorks.com</option>
        </select>
<input type="text" name="query" size="10" class="formelem" value="">
<input type="submit" value="Go" class="formelem gobutton" >
</form>

		  <ol id="access2">
  <li class="first">
    Serena Ng
  </li>
  <li>
      <a href="https://www.mathworks.com/accesslogin/editCommunityProfile.do?uri=http%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Ffileexchange%2F13490-adaptive-robust-numerical-differentiation%2Fcontent%2FDERIVESTsuite%2Fjacobianest" edit="edit_community_profile_link">Create Community Profile</a>
  </li>
  <li>
    <a href="https://www.mathworks.com/accesslogin/logout.do?uri=http%3A%2F%2Fwww.mathworks.com%2Fmatlabcentral%2Ffileexchange%2F13490-adaptive-robust-numerical-differentiation%2Fcontent%2FDERIVESTsuite%2Fjacobianest" id="logout_link">Log Out</a>
  </li>
</ol>


      </div>
	  
        <div id="globalnav">
        <!-- from includes/global_nav.html -->
        <ol>
                <li class=";" >
                        <a href="/matlabcentral/fileexchange/?s_tid=gn_mlc_fx">File Exchange</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/answers/?s_tid=gn_mlc_an">Answers</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/newsreader/?s_tid=gn_mlc_ng">Newsgroup</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/linkexchange/?s_tid=gn_mlc_lx">Link Exchange</a> 
                </li>
                <li class=";" >
                        <a href="http://blogs.mathworks.com/?s_tid=gn_mlc_blg">Blogs</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/trendy/?s_tid=gn_mlc_tnd">Trendy</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/cody/?s_tid=gn_mlc_cody">Cody</a> 
                </li>
                <li class=";" >
                        <a href="/matlabcentral/contest/?s_tid=gn_mlc_cn">Contest</a> 
                </li>
                <li class="icon mathworks" >
                        <a href="/?s_tid=gn_mlc_main">MathWorks.com</a> 
                </li>
        </ol>
      </div>
    </div>
  </div>
</div>

      <div id="middle">
  <div class="wrapper">

    <div id="mainbody" class="columns2">
  
  

  <div class="manifest">

    <div class="ctaBtn ctaBlueBtn btnSmall">
            <div id="download_submission_button" class="btnCont">
              <div class="btn download"><a href="/matlabcentral/fileexchange/downloads/257440/download" title="Download Now">Download Submission</a></div>
            </div>
          </div>


      <p class="license">
      Code covered by the <a href="/matlabcentral/fileexchange/view_license?file_info_id=13490" popup="new_window height=500,width=640,scrollbars=yes">BSD License</a>
      <a href="/matlabcentral/fileexchange/help_license#bsd" class="info notext preview_help" onclick="window.open(this.href,'small','toolbar=no,resizable=yes,status=yes,menu=no,scrollbars=yes,width=600,height=550');return false;">&nbsp;</a>
  </p>



  
  <h3 class="highlights_title">Highlights from <br/>
    <a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation" class="manifest_title">Adaptive Robust Numerical Differentiation</a>
  </h3>
  <ul class='manifest'>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/demo/html/derivest_demo.html" class="example" title="Example">derivest_demo</a></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/demo/html/multivariable_calc_demo.html" class="example" title="Example">multivariable_calc_demo</a></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/derivest.m" class="function" title="Function">derivest(fun,x0,varargin)</a><span class="description">DERIVEST: estimate the n'th derivative of fun at x0, provide an error estimate</span></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/directionaldiff.m" class="function" title="Function">directionaldiff(fun,x0,vec)</a><span class="description">directionaldiff: estimate of the directional derivative of a function of n variables</span></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/gradest.m" class="function" title="Function">gradest(fun,x0)</a><span class="description">gradest: estimate of the gradient vector of an analytical function of n variables</span></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/hessdiag.m" class="function" title="Function">hessdiag(fun,x0)</a><span class="description">HESSDIAG: diagonal elements of the Hessian matrix (vector of second partials)</span></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/hessian.m" class="function" title="Function">hessian(fun,x0)</a><span class="description">hessian: estimate elements of the Hessian matrix (array of 2nd partials)</span></li>
      <li class='manifest'><a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite/jacobianest.m" class="function" title="Function">jacobianest(fun,x0)</a><span class="description">gradest: estimate of the Jacobian matrix of a vector valued function of n variables</span></li>
    <li class="manifest_allfiles">
      <a href="http://www.mathworks.com/matlabcentral/fileexchange/13490-adaptive-robust-numerical-differentiation/content/DERIVESTsuite.zip" id="view_all_files">View all files</a>
    </li>
  </ul>

</div>


  <table cellpadding="0" cellspacing="0" class="details file contents">
    <tr>
      <th class="maininfo">
        


<div id="details">
  <h1 itemprop="name">Adaptive Robust Numerical Differentiation</h1>
  <p id="author">
    by 
    <span itemprop="author" itemscope itemtype="http://schema.org/Person">
      <span itemprop="name"><a href="http://www.mathworks.com/matlabcentral/fileexchange/authors/679">John D&#x27;Errico</a></span>
    </span>
  </p>
  <p>&nbsp;</p>
  <p>
    <span id="submissiondate" 
>
      27 Dec 2006
    </span>
      <span id="date_updated">(Updated 
        <span itemprop="datePublished" content="2011-06-01">01 Jun 2011</span>)
      </span>
  </p>

  <p id="summary">Numerical derivative of an analytically supplied function, also gradient, Jacobian &amp; Hessian</p>


  
</div>

        </div>
      </th>
    </tr>
    <tr>
      <td class="file">
        <table cellpadding="0" cellspacing="0" border="0" class="fileview section">
          <tr class="title">
            <th><span class="heading">jacobianest(fun,x0)</span></th>
          </tr>
          <tr>
            <td>
              
              <div class="codecontainer"><pre class="matlab-code">function [jac,err] = jacobianest(fun,x0)
% gradest: estimate of the Jacobian matrix of a vector valued function of n variables
% usage: [jac,err] = jacobianest(fun,x0)
%
% 
% arguments: (input)
%  fun - (vector valued) analytical function to differentiate.
%        fun must be a function of the vector or array x0.
% 
%  x0  - vector location at which to differentiate fun
%        If x0 is an nxm array, then fun is assumed to be
%        a function of n*m variables.
%
%
% arguments: (output)
%  jac - array of first partial derivatives of fun.
%        Assuming that x0 is a vector of length p
%        and fun returns a vector of length n, then
%        jac will be an array of size (n,p)
%
%  err - vector of error estimates corresponding to
%        each partial derivative in jac.
%
%
% Example: (nonlinear least squares)
%  xdata = (0:.1:1)';
%  ydata = 1+2*exp(0.75*xdata);
%  fun = @(c) ((c(1)+c(2)*exp(c(3)*xdata)) - ydata).^2;
%
%  [jac,err] = jacobianest(fun,[1 1 1])
%
%  jac =
%           -2           -2            0
%      -2.1012      -2.3222     -0.23222
%      -2.2045      -2.6926     -0.53852
%      -2.3096      -3.1176     -0.93528
%      -2.4158      -3.6039      -1.4416
%      -2.5225      -4.1589      -2.0795
%       -2.629      -4.7904      -2.8742
%      -2.7343      -5.5063      -3.8544
%      -2.8374      -6.3147      -5.0518
%      -2.9369      -7.2237      -6.5013
%      -3.0314      -8.2403      -8.2403
%
%  err =
%   5.0134e-15   5.0134e-15            0
%   5.0134e-15            0   2.8211e-14
%   5.0134e-15   8.6834e-15   1.5804e-14
%            0     7.09e-15   3.8227e-13
%   5.0134e-15   5.0134e-15   7.5201e-15
%   5.0134e-15   1.0027e-14   2.9233e-14
%   5.0134e-15            0   6.0585e-13
%   5.0134e-15   1.0027e-14   7.2673e-13
%   5.0134e-15   1.0027e-14   3.0495e-13
%   5.0134e-15   1.0027e-14   3.1707e-14
%   5.0134e-15   2.0053e-14   1.4013e-12
%
%  (At [1 2 0.75], jac should be numerically zero)
%
%
% See also: derivest, gradient, gradest
%
%
% Author: John D'Errico
% e-mail: woodchips@rochester.rr.com
% Release: 1.0
% Release date: 3/6/2007

% get the length of x0 for the size of jac
nx = numel(x0);

MaxStep = 100;
StepRatio = 2.0000001;

% was a string supplied?
if ischar(fun)
  fun = str2func(fun);
end

% get fun at the center point
f0 = fun(x0);
f0 = f0(:);
n = length(f0);
if n==0
  % empty begets empty
  jac = zeros(0,nx);
  err = jac;
  return
end

relativedelta = MaxStep*StepRatio .^(0:-1:-25);
nsteps = length(relativedelta);

% total number of derivatives we will need to take
jac = zeros(n,nx);
err = jac;
for i = 1:nx
  x0_i = x0(i);
  if x0_i ~= 0
    delta = x0_i*relativedelta;
  else
    delta = relativedelta;
  end
  
  % evaluate at each step, centered around x0_i
  % difference to give a second order estimate
  fdel = zeros(n,nsteps);
  for j = 1:nsteps
    fdif = fun(swapelement(x0,i,x0_i + delta(j))) - ...
      fun(swapelement(x0,i,x0_i - delta(j)));
    
    fdel(:,j) = fdif(:);
  end
  
  % these are pure second order estimates of the
  % first derivative, for each trial delta.
  derest = fdel.*repmat(0.5 ./ delta,n,1);
  
  % The error term on these estimates has a second order
  % component, but also some 4th and 6th order terms in it.
  % Use Romberg exrapolation to improve the estimates to
  % 6th order, as well as to provide the error estimate.
  
  % loop here, as rombextrap coupled with the trimming
  % will get complicated otherwise.
  for j = 1:n
    [der_romb,errest] = rombextrap(StepRatio,derest(j,:),[2 4]);
    
    % trim off 3 estimates at each end of the scale
    nest = length(der_romb);
    trim = [1:3, nest+(-2:0)];
    [der_romb,tags] = sort(der_romb);
    der_romb(trim) = [];
    tags(trim) = [];
    
    errest = errest(tags);
    
    % now pick the estimate with the lowest predicted error
    [err(j,i),ind] = min(errest);
    jac(j,i) = der_romb(ind);
  end
end

end % mainline function end

% =======================================
%      sub-functions
% =======================================
function vec = swapelement(vec,ind,val)
% swaps val as element ind, into the vector vec
vec(ind) = val;

end % sub-function end

% ============================================
% subfunction - romberg extrapolation
% ============================================
function [der_romb,errest] = rombextrap(StepRatio,der_init,rombexpon)
% do romberg extrapolation for each estimate
%
%  StepRatio - Ratio decrease in step
%  der_init - initial derivative estimates
%  rombexpon - higher order terms to cancel using the romberg step
%
%  der_romb - derivative estimates returned
%  errest - error estimates
%  amp - noise amplification factor due to the romberg step

srinv = 1/StepRatio;

% do nothing if no romberg terms
nexpon = length(rombexpon);
rmat = ones(nexpon+2,nexpon+1);
% two romberg terms
rmat(2,2:3) = srinv.^rombexpon;
rmat(3,2:3) = srinv.^(2*rombexpon);
rmat(4,2:3) = srinv.^(3*rombexpon);

% qr factorization used for the extrapolation as well
% as the uncertainty estimates
[qromb,rromb] = qr(rmat,0);

% the noise amplification is further amplified by the Romberg step.
% amp = cond(rromb);

% this does the extrapolation to a zero step size.
ne = length(der_init);
rhs = vec2mat(der_init,nexpon+2,ne - (nexpon+2));
rombcoefs = rromb\(qromb'*rhs);
der_romb = rombcoefs(1,:)';

% uncertainty estimate of derivative prediction
s = sqrt(sum((rhs - rmat*rombcoefs).^2,1));
rinv = rromb\eye(nexpon+1);
cov1 = sum(rinv.^2,2); % 1 spare dof
errest = s'*12.7062047361747*sqrt(cov1(1));

end % rombextrap


% ============================================
% subfunction - vec2mat
% ============================================
function mat = vec2mat(vec,n,m)
% forms the matrix M, such that M(i,j) = vec(i+j-1)
[i,j] = ndgrid(1:n,0:m-1);
ind = i+j;
mat = vec(ind);
if n==1
  mat = mat';
end

end % vec2mat



</pre></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>

  </table>


<p id="contactus"><a href="/company/feedback/">Contact us</a></p>

      
</div>
<div class="clearboth">&nbsp;</div>
</div>
</div>
<!-- footer.html -->
<!-- START OF FOOTER -->

<div id="mlc-footer">
  <script type="text/javascript">
function clickDynamic(obj, target_url, tracking_code) {
	var pos=target_url.indexOf("?");
	if (pos<=0) { 
		var linkComponents = target_url + tracking_code;
		obj.href=linkComponents;
	} 
}
</script>
  <div class="wrapper">
    <div>
      <ul id="matlabcentral">
        <li class="copyright first">&copy; 1994-2014 The MathWorks, Inc.</li>
        <li class="first"><a href="/help.html" title="Site Help">Site Help</a></li>
        <li><a href="/company/aboutus/policies_statements/patents.html" title="patents" rel="nofollow">Patents</a></li>
        <li><a href="/company/aboutus/policies_statements/trademarks.html" title="trademarks" rel="nofollow">Trademarks</a></li>
        <li><a href="/company/aboutus/policies_statements/" title="privacy policy" rel="nofollow">Privacy Policy</a></li>
        <li><a href="/company/aboutus/policies_statements/piracy.html" title="preventing piracy" rel="nofollow">Preventing Piracy</a></li>
        <li class="last"><a href="/matlabcentral/termsofuse.html" title="Terms of Use" rel="nofollow">Terms of Use</a></li>
        <li class="icon"><a href="/company/rss/" title="RSS" class="rssfeed" rel="nofollow"><span class="text">RSS</span></a></li>
        <li class="icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_lkd&url=http://www.linkedin.com/company/the-mathworks_2" title="LinkedIn" class="linkedin" rel="nofollow" target="_blank"></a></li>
        <li class="icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_fbk&url=https://plus.google.com/117177960465154322866?prsrc=3" title="Google+" class="google" rel="nofollow" target="_blank"><span class="text">Google+</span></a></li>
        <li class="icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_fbk&url=http://www.facebook.com/MATLAB" title="Facebook" class="facebook" rel="nofollow" target="_blank"><span class="text">Facebook</span></a></li>
        		<li class="last icon"><a href="/programs/bounce_hub_generic.html?s_tid=mlc_twt&url=http://www.twitter.com/MATLAB" title="Twitter" class="twitter" rel="nofollow" target="_blank"><span class="text">Twitter</span></a></li>        
        
      </ul>
      <ul id="mathworks">
        <li class="first sectionhead">Featured MathWorks.com Topics:</li>
        <li class="first"><a href="/products/new_products/latest_features.html" onclick="clickDynamic(this, this.href, '?s_cid=MLC_new')">New Products</a></li>
        <li><a href="/support/" title="support" onclick="clickDynamic(this, this.href, '?s_cid=MLC_support')">Support</a></li>
        <li><a href="/help" title="documentation" onclick="clickDynamic(this, this.href, '?s_cid=MLC_doc')">Documentation</a></li>
        <li><a href="/services/training/" title="training" onclick="clickDynamic(this, this.href, '?s_cid=MLC_training')">Training</a></li>
        <li><a href="/company/events/webinars/" title="Webinars" onclick="clickDynamic(this, this.href, '?s_cid=MLC_webinars')">Webinars</a></li>
        <li><a href="/company/newsletters/" title="newsletters" onclick="clickDynamic(this, this.href, '?s_cid=MLC_newsletters')">Newsletters</a></li>
        <li><a href="/programs/trials/trial_request.html?prodcode=ML&s_cid=MLC_trials" title="MATLAB Trials">MATLAB Trials</a></li>
        
        		<li class="last"><a href="/company/jobs/opportunities/index_en_US.html" title="Careers" onclick="clickDynamic(this, this.href, '?s_cid=MLC_careers')">Careers</a></li>
                 
      </ul>
    </div>
  </div>
</div>
<!-- END OF FOOTER -->


      
      
<!-- SiteCatalyst code version: H.24.4.
Copyright 1996-2012 Adobe, Inc. All Rights Reserved
More info available at http://www.omniture.com -->
<script language="JavaScript" type="text/javascript" src="/scripts/omniture/s_code.js"></script>


<script language="JavaScript" type="text/javascript">



<!--
/************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/
var s_code=s.t();if(s_code)document.write(s_code)//--></script>
<script language="JavaScript" type="text/javascript"><!--
if(navigator.appVersion.indexOf('MSIE')>=0)document.write(unescape('%3C')+'\!-'+'-')
//--></script>
<!--/DO NOT REMOVE/-->
<!-- End SiteCatalyst code version: H.24.4. -->


  

    <!-- BEGIN Qualaroo --> 
<script type="text/javascript">
  var _kiq = _kiq || [];
  (function(){
    setTimeout(function(){
    var d = document, f = d.getElementsByTagName('script')[0], s = d.createElement('script'); s.type = 'text/javascript';
    s.async = true; s.src = '//s3.amazonaws.com/ki.js/49559/ahy.js'; f.parentNode.insertBefore(s, f);
    }, 1);
  })();
</script>
<!-- END Qualaroo --> 

    </body>
</html>
