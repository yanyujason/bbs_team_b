<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" scope="request" value="Home"/>

<%@ include file="../header.jsp" %>

<div id="content">
  <div id="postTable">
    <c:forEach var="post" items="${posts}" varStatus="row">
      <div id="postTitle">
        <c:if test="${post.parentId==0}">
          <h1><c:out value="${post.title}"/></h1>
        </c:if>
      </div>
       <div id="postTitleRe">
          <c:if test="${post.parentId!=0}">
               <h3><c:out value="${post.title}"/></h3>
          </c:if>
       </div>
          <div id="postInFo">
               Author:
            <a href="<c:url value='/user/users/${post.authorName}' />">
               <B><c:out value="${post.authorName}"/></B>
            </a>
               &nbsp Create Time:
               <B><c:out value="${post.createTimeString}"/></B>
               <c:if test="${post.parentId==0}">
                    &nbsp Like <B>${post.likedTimes}</B> times
               </c:if>
          </div>
              </br>
           <div id="postContent">
               <c:out value="${post.content}"/>
           </div>
                <div id="operations">
                    &nbsp Operations:
                             <c:if test="${post.parentId==0}">
                                        <c:if test="${row.index==0}">
                                             <c:if test="${not empty liked}">
                                                    <c:if test="${not liked}">
                                                        <B><a href='javascript:alert("you like this post");location.href="like/${post.postId};"'>Like</a></B>
                                                    </c:if>
                                             </c:if>
                                        </c:if>
                             </c:if>
                           <B>
                              <c:if test="${not empty isAuthor}">
                                <a href="javascript:void(0);" onclick="show_confirm('${post.postId}');">X</a>
                             </c:if>
                          </B>
                 </div>
    </c:forEach>
  </div>

  </br>
 <c:choose>
      <c:when test="${not empty failed}">
          <div id="createPostFailed" class="page-action createPost-failed">
              <i class="messageError">Content cannot be empty!</i>
          </div>
      </c:when>
  </c:choose>
 <div id="createPanel">
    <form action="<c:url value='/posts/${postId}' />" method="post">
        <input type="hidden" id="parentId" name="parentId" value="${mainPost.postId}" />
        <input type="hidden" id="title" name="title" value="Re: ${mainPost.title}" />
            <textarea style="background:white" name="content" id="content"  placeholder="post content" cols="100" rows="6"></textarea>
          </br>
          </br>
        <button type="submit" class="btn">Create</button>
    </form>
 </div>


<script type="text/javascript">
function show_confirm(deletePostId)
{
      document.deletePostForm.deleteReplyPost.value = deletePostId;
      document.deletePostForm.submit();
}
</script>
<form  name="deletePostForm" action="<c:url value='/posts/del' />" method="post">
     <input type="hidden" id="deleteReplyPost" name="deleteReplyPost" >
</form>

  </br>
</div>
<%@ include file="../footer.jsp" %>