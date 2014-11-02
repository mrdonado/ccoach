<?php
namespace classes\General;

class Knowledge
{
    // knowledge
    private $distances;
    private $intervals;
    private $chords;
    private $notes;
    private $scales;
    // singleton instance
    private static $instance;

    // private constructor function
    // to prevent external instantiation
    private function __construct()
    {
    }

    // getInstance method
    public static function getInstance()
    {
        if (!self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * It reads the information in all the knowledge files
     */
    public function readFiles()
    {
        $this->distances = $this->parseFile('knowledge/distances.txt');
        $this->intervals = $this->parseFile('knowledge/intervals.txt');
        $this->chords = $this->parseFile('knowledge/chords.txt');
        $this->notes = $this->parseFile('knowledge/notes.txt');
        $this->scales = $this->parseFile('knowledge/scales.txt');
    }

    /**
     * It parses a knowledge file
     * @param $fileName
     * @return array
     */
    private function parseFile($fileName)
    {
        $handle = fopen($fileName, 'r');
        $data = fread($handle, filesize($fileName));
        $data = explode("\r\n", $data);
        $numData = count($data);
        $parsed = array();
        for ($i = 0; $i < $numData; $i++) {
            $parsed[$i] = explode(" ", $data[$i]);
        }
        return $parsed;
    }

    /**
     * It returns the notes of a given chord
     * @param $chord CMaj7, Em7, DM
     */
    public function getNotesChord($chord)
    {
        $tonic = substr($chord, 0, 1);
        $alteration = substr($chord, 1, 1);
        // the tonic might be flat or sharp
        if ($alteration === 'b' || $alteration === '#') {
            $tonic .= $alteration;
            $chordType = substr($chord, 2);
        } else {
            $chordType = substr($chord, 1);
        }
        $notes = array();
        $notes[0] = $tonic;
        $numChords = count($this->chords);
        $chordIndex = -1;
        for ($i = 0; $i < $numChords; $i++) {
            if ($this->chords[$i][0] === $chordType) {
                $chordIndex = $i;
                break;
            }
        }
        // Unknown chord
        if ($chordIndex == -1) {
            return -1;
        }
        $numIntervals = count($this->chords[$chordIndex]);
        for ($i = 1; $i < $numIntervals; $i++) {
            $notes[$i] = $this->getNoteInterval($tonic, $this->chords[$chordIndex][$i]);
        }
        return $notes;
    }

    /**
     * It returns the notes of the scale
     * @param $tonic
     * @param $scale
     * @return array|int
     */
    public function getNotesScale($tonic, $scale)
    {
        $notes = array();
        $notes[0] = $tonic;
        $numScales = count($this->scales);
        $scaleIndex = -1;
        for ($i = 0; $i < $numScales; $i++) {
            if ($this->scales[$i][0] === $scale) {
                $scaleIndex = $i;
                break;
            }
        }
        // Unknown scale
        if ($scaleIndex == -1) {
            return -1;
        }
        $numIntervals = count($this->scales[$scaleIndex]);
        for ($i = 1; $i < $numIntervals; $i++) {
            $notes[$i] = $this->getNoteInterval($tonic, $this->scales[$scaleIndex][$i]);
        }
        return $notes;
    }

    /**
     * It returns the note for a given interval with a known tonic.
     * @param $tonic C, D, E, F...
     * @param $intervalType 3M, 4J, 7m...
     * @return string C, D#, Gb...
     */
    public function getNoteInterval($tonic, $intervalType)
    {
        $numIntervals = count($this->intervals);
        $distance = 0;
        // The tone distance for this interval is looked up
        for ($i = 0; $i < $numIntervals; $i++) {
            if ($this->intervals[$i][0] === $intervalType) {
                $distance = $this->intervals[$i][1];
                break;
            }
        }
        // If the interval is unknown, -1 is returned
        if ($distance == 0) {
            return -1;
        }

        $tonicIndex = $this->indexOfNote(substr($tonic, 0, 1));
        $intervalIndex = substr($intervalType, 0, 1) - 1;
        $intervalNote = $this->notes[($tonicIndex + $intervalIndex) % 7][0];
        $baseDistance = $this->getDistance($tonic, $intervalNote);
        if ($baseDistance == $distance) {
            return $intervalNote;
        } elseif ($baseDistance == $distance + 0.5) {
            return $intervalNote . 'b';
        } elseif ($baseDistance == $distance - 0.5) {
            return $intervalNote . '#';
        } else {
            return -1;
        }
    }

    /**
     * It returns the tone distance between two notes
     * @param $note1 C, D, E, F...
     * @param $note2 C, D, E, F...
     * @return float|int Distance between the notes
     */
    public function getDistance($note1, $note2)
    {
        $distance = 0;
        // same note
        if ($note1 === $note2) {
            return 0;
        }
        // flat note 1
        if (strrpos($note1, 'b') > -1) {
            $distance += 0.5;
        }
        // sharp note 1
        if (strrpos($note1, '#') > -1) {
            $distance -= 0.5;
        }
        // flat note 2
        if (strrpos($note2, 'b') > -1) {
            $distance -= 0.5;
        }
        // sharp note 2
        if (strrpos($note2, '#') > -1) {
            $distance += 0.5;
        }
        // same note, different alteration
        if (substr($note1, 0, 1) == substr($note2, 0, 1)) {
            return $distance;
        }
        // different notes: distance calculation
        $index1 = $this->indexOfNote(substr($note1, 0, 1));
        while ($distance < 6) {
            $distance += $this->distances[$index1][2];
            if ($this->distances[$index1][1] === substr($note2, 0, 1)) {
                return $distance;
            } else {
                $index1 = ($index1 + 1) % 7;
            }
        }
        return -1;
    }

    /**
     * It returns the numeric index of a note
     * @param $note C, D, E, F, G...
     * @return int 0, 1, 2, 3, 4...
     */
    public function indexOfNote($note)
    {
        for ($i = 0; $i < 7; $i++) {
            if ($note === $this->notes[$i][0]) {
                return $i;
            }
        }
        return -1;
    }
} 