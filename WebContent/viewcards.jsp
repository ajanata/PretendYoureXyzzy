<?xml version="1.0" encoding="UTF-8" ?>
<%--
Copyright (c) 2013-2018, Andy Janata
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions
  and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of
  conditions and the following disclaimer in the documentation and/or other materials provided
  with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--%>
<%--
Interface to view and search all existing cards and card sets.

@author Andy Janata (ajanata@socialgamer.net)
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="com.google.inject.Key" %>
<%@ page import="net.socialgamer.cah.CahModule.IncludeInactiveCardsets" %>
<%@ page import="net.socialgamer.cah.HibernateUtil" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.db.PyxBlackCard" %>
<%@ page import="net.socialgamer.cah.db.PyxCardSet" %>
<%@ page import="net.socialgamer.cah.db.PyxWhiteCard" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.json.simple.JSONValue" %>
<%
  Session hibernateSession = HibernateUtil.instance.sessionFactory.openSession();

ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
boolean includeInactive = injector.getInstance(Key.get(Boolean.TYPE, IncludeInactiveCardsets.class));

// cheap way to make sure we can close the hibernate session at the end of the page
try {
  // load from db
  @SuppressWarnings("unchecked")
  List<PyxCardSet> cardSets = hibernateSession
      .createQuery(PyxCardSet.getCardsetQuery(includeInactive))
      .setReadOnly(true)
      .setCacheable(true)
      .list();
  
  // all of the data to send to the client
  Map<String, Object> data = new HashMap<String, Object>();
  
  // mapping of what card sets each card is in
  Map<Integer, List<Integer>> whiteCardSets = new HashMap<Integer, List<Integer>>();
  Map<Integer, List<Integer>> blackCardSets = new HashMap<Integer, List<Integer>>();
  
  // all of the cards that are actually in a card set
  Set<PyxWhiteCard> whiteCards = new HashSet<PyxWhiteCard>();
  Set<PyxBlackCard> blackCards = new HashSet<PyxBlackCard>();
  
  Map<Integer, Object> cardSetsData = new HashMap<Integer, Object>();
  data.put("cardSets", cardSetsData);
  int i = 0;
  for (PyxCardSet cardSet: cardSets) {
    Map<String, Object> cardSetData = new HashMap<String, Object>();
    cardSetData.put("name", cardSet.getName());
    cardSetData.put("id", cardSet.getId());
    cardSetData.put("description", cardSet.getDescription());

    List<Integer> whiteCardIds = new ArrayList<Integer>(cardSet.getWhiteCards().size());
    for (PyxWhiteCard whiteCard: cardSet.getWhiteCards()) {
      whiteCardIds.add(whiteCard.getId());
      whiteCards.add(whiteCard);
      if (!whiteCardSets.containsKey(whiteCard.getId())) {
        whiteCardSets.put(whiteCard.getId(), new ArrayList<Integer>());
      }
      whiteCardSets.get(whiteCard.getId()).add(cardSet.getId());
    }
    cardSetData.put("whiteCards", whiteCardIds);

    List<Integer> blackCardIds = new ArrayList<Integer>(cardSet.getBlackCards().size());
    for (PyxBlackCard blackCard: cardSet.getBlackCards()) {
      blackCardIds.add(blackCard.getId());
      blackCards.add(blackCard);
      if (!blackCardSets.containsKey(blackCard.getId())) {
        blackCardSets.put(blackCard.getId(), new ArrayList<Integer>());
      }
      blackCardSets.get(blackCard.getId()).add(cardSet.getId());
    }
    cardSetData.put("blackCards", blackCardIds);
    
    cardSetsData.put(i++, cardSetData);
  }
  
  Map<Integer, Object> blackCardsData = new HashMap<Integer, Object>();
  data.put("blackCards", blackCardsData);
  for (PyxBlackCard blackCard: blackCards) {
    Map<String, Object> blackCardData = new HashMap<String, Object>();
    
    blackCardData.put("text", blackCard.getText());
    blackCardData.put("watermark", blackCard.getWatermark());
    blackCardData.put("draw", blackCard.getDraw());
    blackCardData.put("pick", blackCard.getPick());
    blackCardData.put("card_sets", blackCardSets.get(blackCard.getId()));
    
    blackCardsData.put(blackCard.getId(), blackCardData);
  }
  
  Map<Integer, Object> whiteCardsData = new HashMap<Integer, Object>();
  data.put("whiteCards", whiteCardsData);
  for (PyxWhiteCard whiteCard: whiteCards) {
    Map<String, Object> whiteCardData = new HashMap<String, Object>();
    
    whiteCardData.put("text", whiteCard.getText());
    whiteCardData.put("watermark", whiteCard.getWatermark());
    whiteCardData.put("card_sets", whiteCardSets.get(whiteCard.getId()));
    
    whiteCardsData.put(whiteCard.getId(), whiteCardData);
  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pretend You're Xyzzy: View Cards</title>
<script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="js/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.json.js"></script>
<script type="text/javascript" src="js/QTransform.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.tablesorter.js"></script>
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
<link rel="stylesheet" type="text/css" href="jquery-ui.min.css" media="screen" />
<jsp:include page="analytics.jsp" />
<script type="text/javascript">
var data = <%= JSONValue.toJSONString(data) %>;

$(document).ready(function() {
  var cardSetsElem = $('#cardSets'); 
  for (var weight in data.cardSets) {
    var cardSet = data.cardSets[weight];
    cardSetsElem.append(
        '<option value="' + cardSet.id + '" selected="selected">' + cardSet.name + '</option>');
  }
  
  var tableElem = $('#cards');
  for (var id in data.blackCards) {
    var card = data.blackCards[id];
    tableElem.append('<tr id="b' + id + '"><td>Black</td><td>' + card.text + '</td><td>'
        + card.watermark + '</td><td>' + card.draw + '</td><td>' + card.pick + '</td></tr>');
  }
  for (var id in data.whiteCards) {
    var card = data.whiteCards[id];
    tableElem.append('<tr id="w' + id + '"><td>White</td><td>' + card.text + '</td><td>'
        + card.watermark + '</td><td></td><td></td></tr>');
  }

  $('#search').keyup(filter);
  $('#cardSets').change(filter);
  $('#cardTable').tablesorter();
  // pre-sort by text
  $('#cardTextColumn').click();
});

function filter() {
  // hide everything
  $('#cards tr').hide();
  applyFilter(data.blackCards, 'b');
  applyFilter(data.whiteCards, 'w');
}

function applyFilter(cardArray, prefix) {
  var cardSetIds = Array();
  $('#cardSets option:selected').each(function(index, elem) {
    cardSetIds[index] = Number(elem.value);
  });
  
  var query = $('#search').val();
  var regexp = new RegExp(query, 'i');
  for (var id in cardArray) {
    var card = cardArray[id];
    $(cardSetIds).each(function(index, cardSetId) {
      if ($.inArray(cardSetId, card.card_sets) !== -1 && card.text.match(regexp)) {
        $('#' + prefix + id).show();
      }
    });
  }
}
</script>
<style type="text/css">
.sorting {
  cursor: pointer;
}
table td {
  padding: 5px;
}
</style>
</head>
<body>
<div style="float: left;">
  Show only cards from card sets (hold ctrl or cmd to select multiple):
  <br/>
  <select id="cardSets" multiple="multiple" style="height: 150px; width: 450px;">
  </select>
</div>
<div>
  <label for="search" style="padding-left: 10px;"
      title="Search for text in cards. You can use regular expressions.">
    Search card text:
  </label>
  <input type="text" id="search" style="width: 400px;" />
</div>
<div style="clear:both"></div>
<table id="cardTable">
  <thead>
    <tr>
      <th class="sorting" style="width: 75px;">Type</th>
      <th class="sorting" style="width: 100%" id="cardTextColumn">Text</th>
      <th class="sorting" style="width: 100px;">Source</th>
      <th class="sorting" style="width: 75px;">Draw</th>
      <th class="sorting" style="width: 75px;">Pick</th>
    </tr>
  </thead>
  <tbody id="cards">
  </tbody>
</table>
</body>
</html>
<%
} finally {
  hibernateSession.close();
}
%>
