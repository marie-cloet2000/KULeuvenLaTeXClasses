% I use this documentclass to model my pen-and-paper exercise sessions.
%
% Written by Bart Vandewoestyne.
% 
% Updated by Marie Cloet
%
% TODO:
%
%  * The exercise environment should have an extra argument indicating
%    the time the instructor is planning to spend on the exercise.
%
%  * A user should be able to specify the starting time of the exercise
%    session.
%
%  * When specifying 'answers' as an option, the following things should
%    also appear in the document:
%      * In the left margin, the time at which to start with the next
%        exercise.
%      * At the end of the document, a summary containing the total amount
%        of time used for all the exercises.
%    
%  * There shouldn't be so much vertical space in before each list of
%    subexercises.
%
% Interesting packages to look at are written at
%
%   http://filoxus.blogspot.com/2008/02/deferred-printing-in-latex.html
%
% exercise
% exams
% pbsheet
% exerquiz
% examdesign
% assignment
% mathexam
% uebungsblatt
% qcm
% exam
% answers
% probsoln

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kulakexamen}[KU Leuven campus Kulak Kortrijk exam session LaTeX documentclass]

\RequirePackage{ifthen}
\RequirePackage{comment}

\newif\if@printsolutions
\@printsolutionsfalse
\DeclareOption{solutions}{\@printsolutionstrue}
\DeclareOption{nosolutions}{\@printsolutionsfalse}

\newif\if@printkey
\@printkeyfalse
\DeclareOption{key}{\@printkeytrue}
\DeclareOption{nokey}{\@printkeyfalse}

\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{kulakarticle}
}
\ProcessOptions\relax
\LoadClass{kulakarticle}

\RequirePackage[a4paper]{geometry}

\renewcommand{\normalsize}{\fontsize{11}{12}\selectfont}
\newcommand{\solutiontitle}{\noindent\textbf{Antwoord:}\enspace}

\def\printsolutions{\@printsolutionstrue}
\def\noprintsolutions{\@printsolutionsfalse}

\newcounter{exercise}
\renewcommand{\theexercise}{\arabic{exercise}}
\newcounter{solution}
\renewcommand{\thesolution}{\arabic{solution}}

\newenvironment{exercise}[1]{%
  \refstepcounter{exercise}
    \if@printsolutions
      {\subsection*{Oefening \theexercise}}
      {
        \emph{ Gebruikt in {#1}}
      }
    \else
      {\subsection*{Oefening \theexercise}}
    \fi
}

\if@printsolutions
\newenvironment{solution}[1][0pt]%
  {%
    \refstepcounter{solution}
      \par
      \vspace{\parskip}
      \noindent
      {\bf Antwoord:}

  }{%
    \par
	  \nopagebreak
	  \hrulefill
      \vspace{0.5cm}
  }%
\else
\excludecomment{solution}
\fi

\newenvironment{key}[1][0pt]{%
  \if@printkey
    \par
    \vspace{\parskip}
    \noindent
    {\bf Puntenverdeling:}

  \else
    \par
    \vspace*{#1}%
    \setbox\z@\vbox\bgroup
  \fi
}{
  \if@printkey
    \vspace{0.5cm}
  \else
    \egroup
  \fi
}
