export function boolToString(val: boolean) {
  let timerState: string = "Unknown";
  if (val === true) {
    timerState = "On"
  }
  else if (val === false) {
    timerState = "Off"
  }
  return timerState
}