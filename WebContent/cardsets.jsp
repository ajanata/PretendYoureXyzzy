<?xml version="1.0" encoding="UTF-8" ?>
<%--
Copyright (c) 2012, Andy Janata
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
Administration tools.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="net.socialgamer.cah.HibernateUtil" %>
<%@ page import="net.socialgamer.cah.db.BlackCard" %>
<%@ page import="net.socialgamer.cah.db.CardSet" %>
<%@ page import="net.socialgamer.cah.db.WhiteCard" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%
String remoteAddr = request.getRemoteAddr();
//TODO better access control than hard-coding IP addresses.
if (!(remoteAddr.equals("0:0:0:0:0:0:0:1") || remoteAddr.equals("127.0.0.1") ||
    remoteAddr.equals("98.248.33.90") || remoteAddr.equals("207.161.125.132"))) {
  response.sendError(403, "Access is restricted to known hosts");
  return;
}

List<String> messages = new ArrayList<String>();

Session hibernateSession = HibernateUtil.instance.sessionFactory.openSession();

String editParam = request.getParameter("edit");
CardSet editCardSet = null;
if (null != editParam) {
  try {
    editCardSet = (CardSet)hibernateSession.load(CardSet.class, Integer.parseInt(editParam));
  } catch (NumberFormatException nfe) {
    messages.add("Unable to parse or locate requested card set to edit.");
  }
}

String deleteParam = request.getParameter("delete");
if (null != deleteParam) {
  try {
    editCardSet = (CardSet)hibernateSession.load(CardSet.class, Integer.parseInt(deleteParam));
    Transaction t = hibernateSession.beginTransaction();
    hibernateSession.delete(editCardSet);
    t.commit();
    response.sendRedirect("cardsets.jsp");
    return;
  } catch (NumberFormatException nfe) {
    messages.add("Invalid id.");
  }
}


String actionParam = request.getParameter("action");
if ("edit".equals(actionParam)) {
  String idParam = request.getParameter("cardSetId");
  int id = 0;
  try {
    id = Integer.parseInt(idParam);
    if (-1 == id) {
      editCardSet = new CardSet();
    } else {
      editCardSet = (CardSet)hibernateSession.load(CardSet.class, id);
    }
    if (null != editCardSet) {
      String nameParam = request.getParameter("cardSetName");
      String activeParam = request.getParameter("active");
      String[] selectedBlackCardsParam = request.getParameterValues("selectedBlackCards");
      String[] selectedWhiteCardsParam = request.getParameterValues("selectedWhiteCards");
      if (null == nameParam || nameParam.isEmpty() || null == selectedBlackCardsParam ||
          null == selectedWhiteCardsParam) {
        messages.add("You didn't specify something.");
        if (-1 == id) {
          editCardSet = null;
        }
      } else {
        editCardSet.setName(nameParam);
        editCardSet.setActive("on".equals(activeParam));
        List<Integer> blackCardIds = new ArrayList<Integer>(selectedBlackCardsParam.length);
        for (String bc : selectedBlackCardsParam) {
          blackCardIds.add(Integer.parseInt(bc));
        }
        List<Integer> whiteCardIds = new ArrayList<Integer>(selectedWhiteCardsParam.length);
        for (String wc : selectedWhiteCardsParam) {
          whiteCardIds.add(Integer.parseInt(wc));
        }
        @SuppressWarnings("unchecked")
        List<BlackCard> realBlackCards = hibernateSession.createQuery(
            "from BlackCard where id in (:ids)").setParameterList("ids", blackCardIds).
            setReadOnly(true).list();
        @SuppressWarnings("unchecked")
        List<WhiteCard> realWhiteCards = hibernateSession.createQuery(
            "from WhiteCard where id in (:ids)").setParameterList("ids", whiteCardIds).
            setReadOnly(true).list();
        editCardSet.getBlackCards().clear();
        editCardSet.getBlackCards().addAll(realBlackCards);
        editCardSet.getWhiteCards().clear();
        editCardSet.getWhiteCards().addAll(realWhiteCards);
        Transaction t = hibernateSession.beginTransaction();
        hibernateSession.saveOrUpdate(editCardSet);
        t.commit();
        hibernateSession.flush();
        response.sendRedirect("cardsets.jsp");
        return;
      }
    } else {
      messages.add("Unable to find card set with id " + id + ".");
    }
  } catch (Exception e) {
    messages.add("Something went wrong. " + e.toString());
  }
}

@SuppressWarnings("unchecked")
List<CardSet> cardSets = hibernateSession.createQuery("from CardSet order by id")
    .setReadOnly(true).list();

@SuppressWarnings("unchecked")
List<BlackCard> blackCards = hibernateSession.createQuery("from BlackCard order by id")
    .setReadOnly(true).list();

@SuppressWarnings("unchecked")
List<WhiteCard> whiteCards = hibernateSession.createQuery("from WhiteCard order by id")
    .setReadOnly(true).list();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PYX - Edit Card Sets</title>
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
    $('#addBlackCards').click(function() {
      addItem('allBlackCards', 'selectedBlackCards', 'bc');
    });
    $('#removeBlackCards').click(function() {
      removeItem('selectedBlackCards');
    });
    $('#addWhiteCards').click(function() {
      addItem('allWhiteCards', 'selectedWhiteCards', 'wc');
    });
    $('#removeWhiteCards').click(function() {
      removeItem('selectedWhiteCards');
    });
    $('#editForm').submit(function() {
      $('#selectedBlackCards option').each(function() {
        this.selected = true;
      });
      $('#selectedWhiteCards option').each(function() {
        this.selected = true;
      });
    });
  });
  
  /**
   * Add selected items from sourceList to destList, ignoring duplicates.
   */
  function addItem(sourceListId, destListId, idPrefix) {
    //
    $('#' + sourceListId + ' option').filter(':selected').each(function() {
      var existing = $('#' + idPrefix + '_' + this.value);
      if (existing.length == 0) {
        $('#' + destListId).append(
            '<option value="' + this.value + '" id="' + idPrefix + '_' + this.value + '">' +
            this.text + '</option>');
      }
    });
    $('#' + destListId + ' option').sort(function (a, b) {
      return Number(b.value) < Number(a.value);
    }).appendTo('#' + destListId);
  }
  
  /**
   * Remove selected items from list.
   */
  function removeItem(listId) {
    $('#' + listId + ' option').filter(':selected').each(function() {
      this.parentElement.removeChild(this);
    });
  }
</script>
<style>
select {
  height: 300px;
}
</style>
</head>
<body>
<% for (String message : messages) { %>
  <h3><%= message %></h3>
<% } %>
<h2>Existing card sets</h2>
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Delete</th>
      <th>Edit</th>
    </tr>
  </thead>
  <tbody>
    <% for (CardSet cardSet : cardSets) { %>
      <tr>
        <td><%= StringEscapeUtils.escapeXml(cardSet.getName()) %></td>
        <td><a href="?delete=<%= cardSet.getId() %>">Delete</a></td>
        <td><a href="?edit=<%= cardSet.getId() %>">Edit</a></td>
      </tr>
    <% } %>
  </tbody>
</table>
<a href="cardsets.jsp">Create New</a>
<form action="cardsets.jsp" method="post" id="editForm">
  <input type="hidden" name="action" value="edit" />
  <input type="hidden" name="cardSetId"
      value="<%= editCardSet != null ? editCardSet.getId() : -1 %>" />
  <h2>
    <% if (editCardSet != null) { %>
      Editing <span style="text-decoration:italic"><%= editCardSet.getName() %></span>
    <% } else { %>
      Creating new card set
    <% } %>
  </h2>
  <label for="cardSetName">Name:</label>
  <input type="text" name="cardSetName" id="cardSetName"
      value="<%= editCardSet != null ? editCardSet.getName() : "" %>" />
  <br/>
  <label for="active">Active</label>
  <input type="checkbox" name="active" id="active"
      <%= editCardSet != null && !editCardSet.isActive() ? "" : "checked='checked'" %> />
  <br/>
  Available Black Cards:
  <br/>
  <select id="allBlackCards" multiple="multiple" style="height:300px">
    <% for (BlackCard blackCard : blackCards) { %>
      <option value="<%= blackCard.getId() %>"><%= blackCard.toString() %></option>
    <% } %>
  </select>
  <br/>
  <input type="button" id="addBlackCards" value="Add Black Cards" />
  <input type="button" id="removeBlackCards" value="Remove Black Cards" />
  <br/>
  Black Cards in Card Set:
  <br/>
  <select id="selectedBlackCards" name="selectedBlackCards" multiple="multiple">
    <% if (editCardSet != null) { %>
      <% for (BlackCard blackCard : editCardSet.getBlackCards()) { %>
        <option value="<%= blackCard.getId() %>" id="bc_<%= blackCard.getId() %>">
          <%= blackCard.toString() %>
        </option>
      <% } %>
    <% } %>
  </select>
  <br/>
  Available White Cards:
  <br/>
  <select id="allWhiteCards" multiple="multiple" style="height:300px">
    <% for (WhiteCard whiteCard : whiteCards) { %>
      <option value="<%= whiteCard.getId() %>"><%= whiteCard.toString() %></option>
    <% } %>
  </select>
  <br/>
  <input type="button" id="addWhiteCards" value="Add White Cards" />
  <input type="button" id="removeWhiteCards" value="Remove White Cards" />
  <br/>
  White Cards in Card Set:
  <br/>
  <select id="selectedWhiteCards" name="selectedWhiteCards" multiple="multiple">
    <% if (editCardSet != null) { %>
      <% for (WhiteCard whiteCard : editCardSet.getWhiteCards()) { %>
        <option value="<%= whiteCard.getId() %>" id="wc_<%= whiteCard.getId() %>">
          <%= whiteCard.toString() %>
        </option>
      <% } %>
    <% } %>
  </select>
  <br/>
  <input type="submit" />
</form>
</body>
</html>
