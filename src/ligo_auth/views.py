from django.http import HttpResponse


def ligo_auth(request):
    return HttpResponse("META:<br/>" + str(request.META) + "<br/><br/>POST:<br/>" + str(request.POST) + "<br/><br/>GET:<br/>" + str(request.GET))
