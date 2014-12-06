string[int] get_whitelists() {
  string[int] whitelists; int n = 0;
  string raw = visit_url("clan_signup.php?place=managewhitelists");
  matcher whitelist_re = create_matcher("<center><p>You are on \\d+ whitelists:(.*?)</center>" , raw);
  if(whitelist_re.find()) {
    string whitelist_raw = whitelist_re.group(1);
    matcher whitelists_b = create_matcher("<b>(.*?)</b>" , whitelist_raw);
    while(whitelists_b.find()) {
      whitelists[n] = whitelists_b.group(1);
      n = n + 1;
    }
  }
  return whitelists;
}

// Because otherwise I get a delayed cached name when changing quickly
string real_clan_name() {
  string profile = visit_url("showplayer.php?who="+my_id());
  matcher clan_name = create_matcher("Clan: <b><a class=nounder href=[^>]+>(.*?)</a>", profile);
  if(clan_name.find())
    return clan_name.group(1);
  return "";
}

void main() {
  string my_clan = real_clan_name();
  write("<html><body><script src=\"relay_clanhop.js\"></script><select id=clan>");
  if(my_clan == "") write("<option value=\"\" selected=\"selected\"></option>");
  foreach n, clan in get_whitelists() {
    write("<option value=\""+entity_encode(clan)+"\"");
    if(clan == my_clan) write(" selected=\"selected\"");
    write(">"+clan+"</option>");
  }
  write("</select></body></html>");
}

