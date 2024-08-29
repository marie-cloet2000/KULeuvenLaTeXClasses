% I use this documentclass to model my pen-and-paper exercise sessions.
%
% Written by Bart Vandewoestyne.
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
\ProvidesClass{kulexamen}[24/09/2009 K.U.Leuven exam session LaTeX package]

\RequirePackage{ifthen}

\newif\if@printsolutions
\@printsolutionsfalse
\DeclareOption{solutions}{\@printsolutionstrue}
\DeclareOption{nosolutions}{\@printsolutionsfalse} % optional

\newif\if@printkey
\@printkeyfalse
\DeclareOption{key}{\@printkeytrue}
\DeclareOption{nokey}{\@printkeysfalse} % optional

\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{kulakarticle}
}
\ProcessOptions\relax
\LoadClass[a4paper]{kulakarticle}

\RequirePackage[a4paper]{geometry}

\newcommand\coursetitle[1]{\gdef\@coursetitle{#1}}
\newcommand\group[1]{\gdef\@group{#1}}

\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}
\newcommand{\solutiontitle}{\noindent\textbf{Antwoord:}\enspace}

\def\printsolutions{\@printsolutionstrue}
\def\noprintsolutions{\@printsolutionsfalse}

\newcounter{exercise}
\renewcommand{\theexercise}{\arabic{exercise}}
\newcounter{question}
\renewcommand{\thequestion}{\arabic{question}}
\newcounter{solution}
\renewcommand{\thesolution}{\arabic{solution}}
\newcounter{key}
\renewcommand{\thesolution}{\arabic{key}}

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

\newenvironment{question}[1]{%
  \refstepcounter{question}
    \if@printsolutions
      {\subsection*{Vraag \thequestion}}
      {
        \emph{ Gebruikt in {#1}}

      }
    \else
      {\subsection*{Vraag \thequestion}}
    \fi
}

\newenvironment{solution}[1][0pt]%
  {%
    \refstepcounter{solution}
    \if@printsolutions
      {\subsection*{Antwoord:}}
    \else
      \par
      \vspace*{#1}%
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \if@printsolutions
      \vspace{0.5cm}
    \else
      \egroup
    \fi
  }%

\newenvironment{key}[1][0pt]%
  {%
    \refstepcounter{key}
    \if@printkey
      {\subsection*{Verbetersleutel:}}
    \else
      \par
      \vspace*{#1}%
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \if@printkey
      \vspace{0.5cm}
    \else
      \egroup
    \fi
  }%

\newenvironment{explanation}[1][0pt]{%
  \if@printsolutions
    \par
    \vspace{\parskip}
    \noindent
    {\bf Uitleg:}
  \else
    \par
    \vspace*{#1}%
    \setbox\z@\vbox\bgroup
  \fi
}{
  \if@printsolutions
    \vspace{0.5cm}
  \else
    \egroup
  \fi
}
