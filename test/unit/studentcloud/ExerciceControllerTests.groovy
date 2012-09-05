package studentcloud



import org.junit.*
import grails.test.mixin.*

@TestFor(ExerciceController)
@Mock(Exercice)
class ExerciceControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/exercice/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.exerciceInstanceList.size() == 0
        assert model.exerciceInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.exerciceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.exerciceInstance != null
        assert view == '/exercice/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/exercice/show/1'
        assert controller.flash.message != null
        assert Exercice.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/exercice/list'


        populateValidParams(params)
        def exercice = new Exercice(params)

        assert exercice.save() != null

        params.id = exercice.id

        def model = controller.show()

        assert model.exerciceInstance == exercice
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/exercice/list'


        populateValidParams(params)
        def exercice = new Exercice(params)

        assert exercice.save() != null

        params.id = exercice.id

        def model = controller.edit()

        assert model.exerciceInstance == exercice
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/exercice/list'

        response.reset()


        populateValidParams(params)
        def exercice = new Exercice(params)

        assert exercice.save() != null

        // test invalid parameters in update
        params.id = exercice.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/exercice/edit"
        assert model.exerciceInstance != null

        exercice.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/exercice/show/$exercice.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        exercice.clearErrors()

        populateValidParams(params)
        params.id = exercice.id
        params.version = -1
        controller.update()

        assert view == "/exercice/edit"
        assert model.exerciceInstance != null
        assert model.exerciceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/exercice/list'

        response.reset()

        populateValidParams(params)
        def exercice = new Exercice(params)

        assert exercice.save() != null
        assert Exercice.count() == 1

        params.id = exercice.id

        controller.delete()

        assert Exercice.count() == 0
        assert Exercice.get(exercice.id) == null
        assert response.redirectedUrl == '/exercice/list'
    }
}
