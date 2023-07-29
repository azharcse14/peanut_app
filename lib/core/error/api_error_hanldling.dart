
bool handleAPIError(var status) {
  if (status is bool) {
    return !status;
  }
  return status != '1';
}
