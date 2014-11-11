/**
 * Created by jdonado on 12/10/14.
 */

var questions;
var currentQuestion = -1;
var currentAnswer = 0;
var currentQDiv;
var currentType;
var counter = 9999;
var resetCounter = 9999;
var delayAfter = 300;
var answers = new Array();
var rightAnswers = new Array();
var feedbackTime = 1000;

// Timer events
setInterval(function () {
    timerDown()
}, 500);

/**
 * It adds the given answer to the array of answers and checks if it is right.
 * @param answer
 */
function addAnswer(answer) {
    if (currentAnswer === 0) {
        answers[currentQuestion] = new Array();
        if (questions.questions[currentQuestion]['expected'].toString().indexOf(',') == -1) {
            rightAnswers = new Array();
            rightAnswers[0] = questions.questions[currentQuestion]['expected'].toString();
        } else {
            rightAnswers = questions.questions[currentQuestion]['expected'].split(",");
        }
    }

    answers[currentQuestion][currentAnswer++] = answer;
    if ($.inArray(answer.toString(), rightAnswers) === -1) {
        // When a bad answer is given, we advance automatically to the next question
        // (but this one will be asked again later).
        showBad();
        questions.questions[questions.questions.length] = questions.questions[currentQuestion];
        setTimeout(nextQuestion, delayAfter);
        return;
    }
    showGood();
    // When all the right answers have been given, the next question is shown.
    if (currentAnswer == rightAnswers.length) {
        setTimeout(nextQuestion, delayAfter);
    }
}

/**
 * It shows a "Well done" message
 */
function showGood() {
    showFeedback("Good!!");
}

function showFeedback(message){
    var feedbackDiv = $(".feedbackDiv");
    var div = document.createElement("div");
    var className = (Math.floor(Math.random() * 1000)).toString();
    div.className = "feedbackText " + className;
    div.style.display = "none";
    div.innerHTML = message;
    feedbackDiv.append(div);
    $("." + className).fadeIn(1000);
    //feedbackDiv.text("Good!!");
    window.setTimeout(function () {
        hideFeedback(className);
    }, feedbackTime);
}

/**
 * It shows a "You made a mistake" message
 */
function showBad() {
    showFeedback("That was wrong!!");
}

function showTooLate() {
    showFeedback("Too late!!");
}

function hideFeedback(divClass) {
    if (typeof divClass != 'undefined') {
        $("." + divClass).fadeOut(500);
    } else {
        $(".feedbackDiv").fadeOut(500);
    }
}

function timerDown() {
    $(".remainingTime").
        text(counter--);
    if (counter == 0) {
        showTooLate();
        nextQuestion();
    }
}

function startGame() {
    //alert("Game is starting! :D");
    var getVars = "";
    if(typeof trainingQuestionType === "undefined"){
        getVars = "";
    }else{
        getVars = {"questionType": trainingQuestionType};
    }
    $.get("ajax/getQuestions.php", getVars, function (data) {
        //$( ".result" ).html( data );
        //alert( "Load was performed." );
        processData(JSON.parse(JSON.stringify(eval("(" + data + ")"))));
    });
}

function processData(data) {
    console.log(data);
    $(".loading").remove();
    questions = data;
    currentQuestion = -1;
    currentQDiv = null;
    nextQuestion();
}

/**
 * The questions are asked to the user
 */
function nextQuestion() {

    if (++currentQuestion >= questions.questions.length) {
        finishRound();
        return;
    }

    currentAnswer = 0;
// && questions.questions[currentQuestion].type != currentType
    if (currentQDiv != null) {
        currentQDiv.fadeOut(400);
    }
    $(".answeredItem").each(function () {
        $(this).removeClass("answeredItem");
        $(this).addClass("answerItem");
    });
    setTimeout(nextQuestionCont, 400);
}

function nextQuestionCont() {

    counter = resetCounter;

    currentType = questions.questions[currentQuestion].type;

    switch (currentType) {
        /*case "notesOfChord":
         // notes of chord...
         notesOfChord();
         break;
         case "degreeOfChord":
         // degree of chord...
         degreeOfChord();
         break;
         case "areaOfChord":
         // area of chord...
         areaOfChord();
         break;
         case "substitutionOfChord":
         // area of chord...
         substitutionOfChord();
         break;*/
        default:
            // generic question
            genericQuestion();
            break;
    }
    // Event listeners
    $(".answerItem").click(function () {
        addAnswer($(this).data("item"));
        $(this).removeClass("answerItem");
        $(this).addClass("answeredItem");
    });
}

function updateCommon() {
    var currentKey = $(".currentKey");
    var currentScale = $(".currentScale");
    currentKey.text(questions.questions[currentQuestion]['key']);
    currentScale.text(questions.questions[currentQuestion]['mode']);
}

function notesOfChord() {
    var questionDiv = $(".notesOfChord");
    questionDiv.find(".answerItems").empty();
    var shown = (questions.questions[currentQuestion]['shown']).split(",");
    for (var i = 0; i < shown.length; i++) {
        var newDiv = '<div class="answerItem" data-item="' + shown[i] + '">' + shown[i] + '</div>';
        questionDiv.find(".answerItems").append(newDiv);
    }
    currentQDiv = questionDiv;
    updateCommon();
    questionDiv.find(".questionText").text(questions.questions[currentQuestion]['text']);
    questionDiv.find(".questionChord").text(questions.questions[currentQuestion]['chord']);
    //questionDiv.append("NOTES OF CHORD!!");
    questionDiv.fadeIn(1000);
}

function genericQuestion() {
    var questionDiv = $(".genericQuestion");
    questionDiv.find(".answerItems").empty();
    var shown = (questions.questions[currentQuestion]['shown']).split(",");
    for (var i = 0; i < shown.length; i++) {
        var newDiv = '<div class="answerItem" data-item="' + shown[i] + '">' + shown[i] + '</div>';
        questionDiv.find(".answerItems").append(newDiv);
    }
    currentQDiv = questionDiv;
    updateCommon();
    questionDiv.find(".questionText").text(questions.questions[currentQuestion]['text']);
    questionDiv.find(".questionElement").text(questions.questions[currentQuestion]['questionElement']);
    //questionDiv.append("NOTES OF CHORD!!");
    questionDiv.fadeIn(1000);
}

function degreeOfChord() {
    var questionDiv = $(".degreeOfChord");
    currentQDiv = questionDiv;
    updateCommon();
    questionDiv.find(".questionText").text(questions.questions[currentQuestion]['text']);
    questionDiv.find(".questionChord").text(questions.questions[currentQuestion]['chord']);
    //questionDiv.append("DEGREE OF CHORD!!");
    //$(".question").fadeOut(0);
    questionDiv.fadeIn(1000);
}

function areaOfChord() {
    var questionDiv = $(".areaOfChord");
    currentQDiv = questionDiv;
    updateCommon();
    questionDiv.find(".questionText").text(questions.questions[currentQuestion]['text']);
    questionDiv.find(".questionChord").text(questions.questions[currentQuestion]['chord']);
    //questionDiv.append("AREA OF CHORD!!");
    //$(".question").fadeOut(0);
    questionDiv.fadeIn(1000);
}

function substitutionOfChord() {
    var questionDiv = $(".substitutionOfChord");
    currentQDiv = questionDiv;
    updateCommon();
    questionDiv.find(".questionText").text(questions.questions[currentQuestion]['text']);
    questionDiv.find(".questionChord").text(questions.questions[currentQuestion]['chord']);
    //questionDiv.append("SUBSTITUTION OF CHORD!!");
    //$(".question").fadeOut(0);
    questionDiv.fadeIn(1000);
}

function finishRound() {
    alert("Se acabó lo que se daba!");
    counter = -1;
}