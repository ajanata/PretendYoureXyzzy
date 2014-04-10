/**
 * Copyright (c) 2014, Andy Janata
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package net.socialgamer.cah.db;

import java.util.Date;

import javax.annotation.Nonnull;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.Session;


/**
 * A user account.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Entity
@Table(name = "accounts")
public class Account {

  @Id
  @GeneratedValue
  private int id;

  // TODO constant this somewhere
  @Column(length = 30, nullable = false)
  private String username;
  @Column(length = 100, nullable = true)
  private String email;
  private boolean emailVerified;
  private boolean lockedOut;
  // FIXME don't use plaintext once I have reference material
  @Column(length = 30, nullable = false)
  private String password;
  // TODO tokens for email verification

  /**
   * Flag to indicate this well-known name is actually that person.
   */
  private boolean verifiedPerson;
  /**
   * Super flag to say this user can do anything in the system.
   */
  private boolean root;
  private boolean canKickFromServer;
  private boolean canBanFromServer;
  private boolean canKickFromAnyGame;
  private boolean canIgnoreGamePasswords;
  private boolean canIgnoreGameLimits;
  private boolean canIgnoreServerLimits;

  @Column(nullable = false)
  private Date created;
  @Column(nullable = false)
  private Date lastSeen;

  public int getId() {
    return id;
  }

  public void setId(final int id) {
    this.id = id;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(final String username) {
    this.username = username;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(final String email) {
    this.email = email;
  }

  public boolean isEmailVerified() {
    return emailVerified;
  }

  public void setEmailVerified(final boolean emailVerified) {
    this.emailVerified = emailVerified;
  }

  public boolean isLockedOut() {
    return lockedOut;
  }

  public void setLockedOut(final boolean lockedOut) {
    this.lockedOut = lockedOut;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(final String password) {
    this.password = password;
  }

  public boolean isVerifiedPerson() {
    return verifiedPerson;
  }

  public void setVerifiedPerson(final boolean verifiedPerson) {
    this.verifiedPerson = verifiedPerson;
  }

  public boolean isRoot() {
    return root;
  }

  public void setRoot(final boolean root) {
    this.root = root;
  }

  public boolean isCanKickFromServer() {
    return canKickFromServer;
  }

  public void setCanKickFromServer(final boolean canKickFromServer) {
    this.canKickFromServer = canKickFromServer;
  }

  public boolean isCanBanFromServer() {
    return canBanFromServer;
  }

  public void setCanBanFromServer(final boolean canBanFromServer) {
    this.canBanFromServer = canBanFromServer;
  }

  public boolean isCanKickFromAnyGame() {
    return canKickFromAnyGame;
  }

  public void setCanKickFromAnyGame(final boolean canKickFromAnyGame) {
    this.canKickFromAnyGame = canKickFromAnyGame;
  }

  public boolean isCanIgnoreGamePasswords() {
    return canIgnoreGamePasswords;
  }

  public void setCanIgnoreGamePasswords(final boolean canIgnoreGamePasswords) {
    this.canIgnoreGamePasswords = canIgnoreGamePasswords;
  }

  public boolean isCanIgnoreGameLimits() {
    return canIgnoreGameLimits;
  }

  public void setCanIgnoreGameLimits(final boolean canIgnoreGameLimits) {
    this.canIgnoreGameLimits = canIgnoreGameLimits;
  }

  public boolean isCanIgnoreServerLimits() {
    return canIgnoreServerLimits;
  }

  public void setCanIgnoreServerLimits(final boolean canIgnoreServerLimits) {
    this.canIgnoreServerLimits = canIgnoreServerLimits;
  }

  public Date getCreated() {
    return created;
  }

  public void setCreated(final Date created) {
    this.created = created;
  }

  public Date getLastSeen() {
    return lastSeen;
  }

  public void setLastSeen(final Date lastSeen) {
    this.lastSeen = lastSeen;
  }

  public static Account getAccount(@Nonnull final Session session,
      @Nonnull final String username) {
    return (Account) session.createQuery("from Account where username = :username")
        .setParameter("username", username).uniqueResult();
  }

}
